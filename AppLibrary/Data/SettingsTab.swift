import Foundation

enum SettingsTab: String, Identifiable, CustomStringConvertible, CaseIterable {
	case display
	case directories

	var id: String { rawValue }

	var description: String { rawValue.capitalized }

	init?(index: Int) {
		guard let result = Self.allCases.first(where: { $0.index == index }) else {
			return nil
		}
		self = result
	}

	var index: Int {
		switch self {
			case .display: return 0
			case .directories: return 1
		}
	}

	var symbolName: String {
		switch self {
			case .display: return "display"
			case .directories: return "folder"
		}
	}
}
