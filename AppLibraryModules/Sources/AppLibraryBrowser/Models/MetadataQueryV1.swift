import AppLibraryStorage
import Foundation
import OSLog

final class MetadataQueryV1 {
	private var state: State

	init() {
		state = .inactive
	}
}

// MARK: - Supporting Data

private extension MetadataQueryV1 {
	enum State {
		case inactive
		case active(query: NSMetadataQuery, observer: any NSObjectProtocol, completionHandler: (NSMetadataQuery) -> Void)
	}
}

// MARK: - Properties

extension MetadataQueryV1 {
	public var isRunning: Bool {
		switch state {
			case .inactive: false
			case .active: true
		}
	}
}

// MARK: -

extension MetadataQueryV1 {
	public func start(
		query: NSMetadataQuery,
		completionHandler: @escaping (NSMetadataQuery) -> Void
	) throws {
		let observer = NotificationCenter.default.addObserver(
			forName: BrowserModel.metadataQueryNotificationName,
			object: query,
			queue: nil,
			using: finish
		)

		state = .active(query: query, observer: observer, completionHandler: completionHandler)

		guard query.start() else {
			stop(query: query, observer: observer)
			throw Failure.queryStartFailure
		}
	}

	@Sendable
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
		if query.isStarted {
			query.stop()
		}
		state = .inactive

		NotificationCenter.default.removeObserver(observer, name: BrowserModel.metadataQueryNotificationName, object: query)
	}
}

// MARK: - Convenience

extension MetadataQueryV1 {
	public func start(
		configureQuery: (NSMetadataQuery) throws -> Void,
		completionHandler: @escaping (NSMetadataQuery) -> Void
	) throws {
		let query = NSMetadataQuery()
		try configureQuery(query)

		try start(query: query, completionHandler: completionHandler)
	}

	public func stop() {
		guard case let .active(query, observer, _) = state else {
			return
		}
		stop(query: query, observer: observer)
	}
}
