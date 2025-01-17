import AppKit

public extension NSScreen {
	static func index(of screen: NSScreen?) -> Int? {
		guard let screen else {
			return nil
		}
		return NSScreen.screens.firstIndex(of: screen)
	}
}