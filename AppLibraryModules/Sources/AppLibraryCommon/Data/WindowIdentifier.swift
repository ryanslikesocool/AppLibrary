public enum WindowIdentifier: String {
	case appLibrary
	case settings = "com_apple_SwiftUI_Settings_window"
	case about
}

// MARK: - Sendable

extension WindowIdentifier: Sendable { }

// MARK: - NSUserInterfaceItemIdentifierProtocol

extension WindowIdentifier: NSUserInterfaceItemIdentifierProtocol { }
