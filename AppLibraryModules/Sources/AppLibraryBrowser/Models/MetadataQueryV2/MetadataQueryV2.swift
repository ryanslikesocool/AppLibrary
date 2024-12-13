import AppLibraryStorage
import Combine
import Foundation
import OSLog

@MainActor
final class MetadataQueryV2: ObservableObject {
	@Published private var state: InternalState

	public var results: [NSMetadataItem]? {
		switch state {
			case let .complete(results): results
			default: nil
		}
	}

	public init() {
		state = .inactive
	}
}

// MARK: - Constants

private extension MetadataQueryV2 {
	nonisolated static let logger: Logger = Logger(category: MetadataQueryV2.self)

	nonisolated static let completionNotificationName: Notification.Name = .NSMetadataQueryDidFinishGathering
}

// MARK: - Supporting Data

private extension MetadataQueryV2 {
	enum InternalState {
		case inactive
		case running(query: NSMetadataQuery, resultSubscriber: AnyCancellable)
		case complete(results: [NSMetadataItem])
	}
}

// MARK: - Local Functions

extension MetadataQueryV2 {
	private func start(
		configureQuery: (NSMetadataQuery) throws -> Void
	) throws {
		/// # validate current state
		switch state {
			case .inactive,
			     .complete:
				break
			case .running:
				// Soft failure
				Self.logger.info("Cannot start a new query because one is already running.")
				return
		}

		/// # create query
		let query = NSMetadataQuery()
		try configureQuery(query)

		/// # validate search scopes
		guard !query.searchScopes.isEmpty else {
			throw Failure.noSearchScopes
		}

		/// # configure completion
		let resultSubscriber = NotificationCenter.default.publisher(for: Self.completionNotificationName, object: query)
			.sink(receiveValue: finish)

		/// # execute
		// NOTE: `start` must be called on the main thread
		guard query.start() else {
			stop(query: query, resultSubscriber: resultSubscriber)

			// TODO: Should this fail a little softer?
			// probably not...
			throw Failure.queryStartFailure
		}

		state = .running(query: query, resultSubscriber: resultSubscriber)
		Self.logger.debug("Starting query...")
	}

	private func finish(notification: Notification) {
		/// # validate current state
		guard case let .running(query, resultSubscriber) = state else {
			preconditionFailure("A query was not running.  This notification should not have been received.")
		}

		/// # validate notification object
		guard
			let notificationObject = notification.object as? NSMetadataQuery,
			notificationObject === query
		else {
			preconditionFailure("Received \(notification.name) from an unexpected object.")
		}

		/// # retrieve results
		let results = query.results(as: NSMetadataItem.self)

		state = .complete(results: results)
		stop(query: query, resultSubscriber: resultSubscriber)

		Logger.module.debug("Finished query.")
	}

	public func stop() {
		guard case let .running(query, resultSubscriber) = state else {
			return
		}
		stop(query: query, resultSubscriber: resultSubscriber)
	}

	private func stop(query: NSMetadataQuery, resultSubscriber: AnyCancellable) {
		// VALIDATE: Can queries safely be stopped
		// without checking if they've started?
		query.stop()
		resultSubscriber.cancel()

		Self.logger.debug("Stopped query.")
	}
}

// MARK: - Async

extension MetadataQueryV2 {
	/// Run a metadata query.
	func run(
		configureQuery: (NSMetadataQuery) throws -> Void
	) async throws -> [NSMetadataItem] {
		defer {
			self.state = .inactive
		}

		try start(configureQuery: configureQuery)

		/// # wait for query completion
		await withCheckedContinuation { continuation in
			var subscriber: AnyCancellable?
			subscriber = $state
				.filter { state in
					// VALIDATE: Is this filter correct?
					// Should it include `.inactive`?
					switch state {
						case .complete: true
						case .inactive, .running: false
					}
				}
				.sink { _ in
					subscriber?.cancel()

					continuation.resume()
				}
		}

		/// # retrieve results
		guard case let .complete(results) = state else {
			throw Failure.queryCompletionFailure
		}

		return results
	}
}
