import AppIntents
import AppLibraryResources
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

// MARK: - Codable

extension LibraryLayout: Codable { }

// MARK: - StaticDisplayRepresentable

extension LibraryLayout: StaticDisplayRepresentable {
	public static let typeDisplayRepresentation = TypeDisplayRepresentation(
		name: LocalizedStringResource("TITLE", table: Self.localizationTable),
	)

	public static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.list: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.LIST.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .square_grid_3x3),
		),

		.grid: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.GRID.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .list_bullet),
		),
	]
}

// MARK: - Constants

private extension LibraryLayout {
	static let localizationTable = "LibraryLayoutPicker"
}
