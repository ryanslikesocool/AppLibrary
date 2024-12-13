import AppKit

public extension NSUserInterfaceItemIdentifier {
	init(_ identifier: some NSUserInterfaceItemIdentifierProtocol) {
		self.init(rawValue: identifier.rawValue)
	}
}