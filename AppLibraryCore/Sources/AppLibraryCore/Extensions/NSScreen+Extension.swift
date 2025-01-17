import AppKit

public extension NSScreen {
	/// Retrieve the index of the given `screen` in the
	/// [`screens`]( https://developer.apple.com/documentation/appkit/nsscreen/screens )
	/// array.
	///
	/// - Parameter screen: The screen to retrieve the index of.
	/// - Returns: The index of the given `screen` in the
	/// [`screens`]( https://developer.apple.com/documentation/appkit/nsscreen/screens )
	/// array, or `nil` if the given `screen` is `nil` or not present.
	static func index(of screen: NSScreen?) -> Int? {
		guard let screen else {
			return nil
		}
		return NSScreen.screens.firstIndex(of: screen)
	}
}
