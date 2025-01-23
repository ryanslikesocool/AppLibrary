import AppKit
import SwiftUI

public extension NSFont.TextStyle {
	/// Create a text style from its SwiftUI `Font` equivalent.
	///
	/// - Important: Only standard fonts that are declared by SwiftUI are currently supported.
	init?(for font: Font) {
		guard let result: Self = switch font {
			case .largeTitle: .largeTitle
			case .title: .title1
			case .title2: .title2
			case .title3: .title3
			case .headline: .headline
			case .subheadline: .subheadline
			case .callout: .callout
			case .caption: .caption1
			case .caption2: .caption2
			case .footnote: .footnote
			default: nil
		} else {
			return nil
		}
		self = result
	}

	/// Create a text style from its SwiftUI `Font` equivalent.
	///
	/// - Important: Only standard fonts that are declared by SwiftUI are currently supported.
	// NOTE: This initializer is disfavored over the initializer that receives a non-optional `Font`.
	@_disfavoredOverload
	init?(for font: Font?) {
		guard let font else {
			return nil
		}
		self.init(for: font)
	}
}
