import AppKit

extension NSEvent.ModifierFlags {
	func enumerated() -> [Self] {
		Self.allCases.filter(contains)
	}
}
