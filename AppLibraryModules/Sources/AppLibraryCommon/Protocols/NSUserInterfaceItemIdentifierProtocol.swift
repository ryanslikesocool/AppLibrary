import AppKit

public protocol NSUserInterfaceItemIdentifierProtocol: RawRepresentable where
	RawValue == String
{ }

// MARK: - Intrinsic

public extension NSUserInterfaceItemIdentifierProtocol {
	init?(_ identifier: NSUserInterfaceItemIdentifier) {
		self.init(rawValue: identifier.rawValue)
	}
}
