import AppLibraryStorage
import Foundation
import OSLog

final class MetadataQuery {
	private var state: State

	init() {
		state = .inactive
	}

	deinit {
		stop()
	}
}

// MARK: - Constants

private extension MetadataQuery {
	nonisolated static let logger: Logger = Logger(category: MetadataQuery.self)

	nonisolated static var notificationName: Notification.Name { .NSMetadataQueryDidFinishGathering }
}

// MARK: - Supporting Data

private extension MetadataQuery {
	enum State {
		case inactive
		case active(query: NSMetadataQuery, observer: any NSObjectProtocol, completionHandler: (NSMetadataQuery) -> Void)
	}
}

// MARK: - Properties

extension MetadataQuery {
	public var isRunning: Bool {
		switch state {
			case .inactive: false
			case .active: true
		}
	}
}

// MARK: -

extension MetadataQuery {
	public func start(
		query: NSMetadataQuery,
		completionHandler: @escaping (NSMetadataQuery) -> Void
	) throws {
		let observer = NotificationCenter.default.addObserver(
			forName: Self.notificationName,
			object: query,
			queue: nil,
			using: finish
		)

		state = .active(query: query, observer: observer, completionHandler: completionHandler)

		guard query.start() else {
			Self.logger.debug("Failed to start query.")
			stop(query: query, observer: observer)
			throw Failure.queryStartFailure
		}

		Self.logger.debug("Started query.")
	}

	private func finish(notification: Notification) {
		guard case let .active(query, observer, completionHandler) = state else {
			preconditionFailure("Received a notification while the query was not active.")
		}
		guard
			let notificationObject = notification.object as? NSMetadataQuery,
			notificationObject === query
		else {
			preconditionFailure("Received \(notification.name) from an invalid object.")
		}

		stop(query: query, observer: observer)
		completionHandler(query)
	}

	private func stop(query: NSMetadataQuery, observer: any NSObjectProtocol) {
		query.stop()
		state = .inactive

		NotificationCenter.default.removeObserver(observer, name: Self.notificationName, object: query)

		Self.logger.debug("Stopped query.")
	}
}

// MARK: - Convenience

extension MetadataQuery {
	public func stop() {
		guard case let .active(query, observer, _) = state else {
			return
		}
		stop(query: query, observer: observer)
	}
}

// MARK: - Async

extension MetadataQuery {
	public func run(
		isolation: isolated (any Actor)? = #isolation,
		query: NSMetadataQuery
	) async throws {
//		try await withTaskCancellationHandler {
			try await withCheckedThrowingContinuation { continuation in
				do {
					try start(query: query) { _ in
						continuation.resume()
					}
				} catch {
					continuation.resume(throwing: error)
				}
			}
//		} onCancel: {
//			stop()
//		}
	}

	public static func run(
		isolation: isolated (any Actor)? = #isolation,
		query: NSMetadataQuery
	) async throws {
		try await MetadataQuery().run(query: query)
	}
}
