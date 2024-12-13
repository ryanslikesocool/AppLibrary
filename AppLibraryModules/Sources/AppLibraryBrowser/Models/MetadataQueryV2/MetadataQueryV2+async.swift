import Foundation

private extension MetadataQueryV2 {
	// NOTE: Unfortunately, this isn't safe.
	// `NSMetadataQuery` is explicitly not `Sendable`,
	// and can't be used as the notification `object`.
//	nonisolated func runQuery(
//		_ query: NSMetadataQuery,
//		notificationCenter: NotificationCenter = .default
//	) async -> [NSMetadataItem] {
//		let notificationName = Self.completionNotificationName
//
//		for await notification in notificationCenter
//			.notifications(named: notificationName, object: query)
//		{
//			Self.assertNotificationObject(notification, equals: query)
//			return query.results(as: NSMetadataItem.self) // one-shot
//		}
//
//		// Should this fail a little harder?
//		return []
//	}

	// NOTE: This *also* isn't safe.
	// Another implementation option similar to the previous function.
	// I'm not sure if it could actually work though.
	// It may attempt to receive notifications forever.
	// It also doesn't validate that the recieved notifications have the correct `object`.
//	nonisolated func runQuery(
//		_ query: NSMetadataQuery,
//		notificationCenter: NotificationCenter = .default
//	) async -> [NSMetadataItem] {
//		let notificationName = Self.completionNotificationName
//
//		return await notificationCenter
//			.notifications(named: notificationName, object: query)
//			.compactMap { notification -> [NSMetadataItem]? in
//				if Self.validateNotificationObject(notification, equals: query) {
//					query.results(as: NSMetadataItem.self)
//				} else {
//					nil
//				}
//			}
//			.reduce(into: [NSMetadataItem]()) { partialResult, element in
//				partialResult.append(contentsOf: element)
//			}
//			// Alternatively...
//			// .reduce([NSMetadataItem](), +)
//	}

	// NOTE: This *also* isn't safe.
//	nonisolated func runQuery(
//		_ query: NSMetadataQuery,
//		notificationCenter: NotificationCenter = .default
//	) async -> [NSMetadataItem] {
//		let notificationName = Self.completionNotificationName
//
//		await withCheckedContinuation { continuation in
//			let observer = notificationCenter.addObserver(
//				forName: notificationName,
//				object: query,
//				queue: nil
//			) { notification in
//				Self.assertNotificationObject(notification, equals: query)
//				notificationCenter.removeObserver(
//					observer,
//					name: notificationName,
//					object: query
//				)
//
//				let results = query.results(as: NSMetadataItem.self)
//				continuation.resume(returning: results)
//			}
//		}
//	}

	// Utility functions for the functions above
//	private nonisolated static func validateNotificationObject<T>(_ notification: Notification, equals target: T) -> Bool where
//		T: AnyObject
//	{
//		if
//			let notificationObject = notification.object as? T,
//			notificationObject === target
//		{
//			true
//		} else {
//			false
//		}
//	}
//
//	private nonisolated static func assertNotificationObject<T>(_ notification: Notification, equals target: T) where T: AnyObject {
//		guard validateNotificationObject(notification, equals: target) else {
//			preconditionFailure("Received \(notification.name) from an unexpected object.")
//		}
//	}
}
