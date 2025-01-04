import Foundation

public enum LibraryLayout: String {
	case list
	case grid
}

// MARK: - Sendable

extension LibraryLayout: Sendable { }

// MARK: - Equatable

extension LibraryLayout: Equatable { }

// MARK: - Hashable

extension LibraryLayout: Hashable { }

// MARK: - Identifiable

extension LibraryLayout: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension LibraryLayout: Codable { }

// MARK: - CustomLocalizedStringResourceConvertible

extension LibraryLayout: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		switch self {
			case .list: .libraryLayoutPicker.item.list
			case .grid: .libraryLayoutPicker.item.grid
		}
	}
}