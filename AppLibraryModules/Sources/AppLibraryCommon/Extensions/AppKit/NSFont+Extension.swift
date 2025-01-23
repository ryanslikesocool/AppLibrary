import AppKit
import SwiftUI

public extension NSFont {
	/// Returns the font associated with the given SwiftUI `Font`.
	///
	/// - Important: Only standard fonts that are declared by SwiftUI are currently supported.
	///
	/// - Parameters:
	///   - font: The SwiftUI `Font` to find an associated
	///   [`NSFont.TextStyle`]( https://developer.apple.com/documentation/appkit/nsfont/textstyle )
	///   for.
	///   - options: A dictionary you use to further configure the returned font.
	///   See
	///   [`NSFont.TextStyleOptionKey`]( https://developer.apple.com/documentation/appkit/nsfont/textstyleoptionkey )
	///   for a list of valid keys.
	///   Pass an empty dictionary to use the default configuration.
	/// - Returns: The font associated with the given SwiftUI `font`, if one could be found; `nil` otherwise.
	class func preferredFont(
		for font: Font?,
		options: [TextStyleOptionKey: Any] = [:]
	) -> NSFont? {
		guard let textStyle = NSFont.TextStyle(for: font) else {
			return nil
		}
		return NSFont.preferredFont(forTextStyle: textStyle, options: options)
	}
}
