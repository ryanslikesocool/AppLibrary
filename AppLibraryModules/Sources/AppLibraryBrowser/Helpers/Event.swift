import Combine
import Foundation

enum Event {
	static let scrollToApp: Notification.Name = Notification.Name("AppLibrary.ScrollToApp")

	enum Publisher {
		static let scrollToApp: NotificationCenter.Publisher = NotificationCenter.default.publisher(for: Event.scrollToApp)
	}
}
