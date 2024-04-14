import AppLibraryStorage
import SwiftUI

extension LibraryLayout {
	var iconSize: Double {
		switch self {
			case .list: 56
			case .grid: 48
		}
	}

	var font: Font {
		switch self {
			case .list: .body
			case .grid: .footnote
		}
	}

	var padding: CGFloat {
		switch self {
			case .list: 16
			case .grid: 0
		}
	}
}
