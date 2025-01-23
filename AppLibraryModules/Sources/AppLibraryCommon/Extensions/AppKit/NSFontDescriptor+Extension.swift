import AppKit
import SwiftUI

public extension NSFontDescriptor {
	/// Returns the font descriptor associated with the given SwiftUI `Font`.
	///
	/// The font descriptor contains a dictionary of attributes that you use to create an
	/// [`NSFont`]( https://developer.apple.com/documentation/appkit/nsfont )
	/// object.
	/// See
	/// [`NSFontDescriptor`]( https://developer.apple.com/documentation/appkit/nsfontdescriptor )
	/// for more information.
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
	/// - Returns: The font descriptor that contains the given SwiftUI `font`, if one could be found; `nil` otherwise.
	class func preferredFontDescriptor(
		for font: Font?,
		options: [NSFont.TextStyleOptionKey: Any] = [:]
	) -> NSFontDescriptor? {
		guard let textStyle = NSFont.TextStyle(for: font) else {
			return nil
		}
		return preferredFontDescriptor(forTextStyle: textStyle, options: options)
	}
}
