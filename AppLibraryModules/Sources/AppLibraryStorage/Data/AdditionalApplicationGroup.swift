import AppIntents

public enum AdditionalApplicationGroup: UInt8 {
	/// ## See Also
	/// - ``Set/recentlyAdded``
	case recentlyAdded

	/// ## See Also
	/// - ``Set/recentlyUpdated``
	case recentlyUpdated
}

// MARK: - Sendable

extension AdditionalApplicationGroup: Sendable { }

// MARK: - Equatable

extension AdditionalApplicationGroup: Equatable { }

// MARK: - Hashable

extension AdditionalApplicationGroup: Hashable { }

// MARK: - Codable

extension AdditionalApplicationGroup: Codable { }

// MARK: - CaseIterable

extension AdditionalApplicationGroup: CaseIterable { }

// MARK: - CaseDisplayRepresentable

extension AdditionalApplicationGroup: CaseDisplayRepresentable {
	public static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.recentlyAdded: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.RECENTLY_ADDED.TITLE", table: Self.localizationTable),
			subtitle: LocalizedStringResource("ITEM.RECENTLY_ADDED.DESCRIPTION", table: localizationTable)
		),

		.recentlyUpdated: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.RECENTLY_UPDATED.TITLE", table: Self.localizationTable),
			subtitle: LocalizedStringResource("ITEM.RECENTLY_UPDATED.DESCRIPTION", table: localizationTable)
		),
	]
}

// MARK: - Constants

private extension AdditionalApplicationGroup {
	static let localizationTable = "AdditionalApplicationGroups"
}
