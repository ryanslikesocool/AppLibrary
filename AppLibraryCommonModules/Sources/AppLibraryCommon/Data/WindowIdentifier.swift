public enum WindowIdentifier: String {
	case appLibrary
	case settings
	case about
}

// MARK: - Sendable

extension WindowIdentifier: Sendable { }

// MARK: - NSUserInterfaceItemIdentifierProtocol

extension WindowIdentifier: NSUserInterfaceItemIdentifierProtocol { }