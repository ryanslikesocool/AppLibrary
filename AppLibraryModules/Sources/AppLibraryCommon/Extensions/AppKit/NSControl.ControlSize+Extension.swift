import AppKit
import SwiftUI

public extension NSControl.ControlSize {
	init(_ controlSize: SwiftUI.ControlSize) {
		self = switch controlSize {
			case .regular: .regular
			case .small: .small
			case .mini: .mini
			case .large: .large
			default:
				preconditionFailure()
		}
	}
}