import AppLibraryStorage
import SwiftUI

extension LibraryLayout {
	var iconSize: Double {
		switch self {
			case .list: 56
			case .grid: 48
		}
	}

	var padding: CGFloat {
		switch self {
			case .list: 16
			case .grid: 8
		}
	}

	var xDimension: Int {
		switch self {
			case .list: 1
			case .grid: 4
		}
	}

	var appTileStyle: AnyAppTileStyle {
		switch self {
			case .list: AnyAppTileStyle(style: .list)
			case .grid: AnyAppTileStyle(style: .grid)
		}
	}
}
