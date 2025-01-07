import AppKit

public extension NSUserInterfaceItemIdentifier {
	init<ID>(_ identifier: ID) where
		ID: NSUserInterfaceItemIdentifierProtocol
	{
		self.init(rawValue: identifier.rawValue)
	}
}
