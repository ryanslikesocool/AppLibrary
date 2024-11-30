import AppLibraryCommon

public extension AdditionalApplicationGroup {
	typealias Set = EnumOptionSet<AdditionalApplicationGroup>
}

// MARK: - Constants

public extension AdditionalApplicationGroup.Set {
	static let recentlyAdded: Self = Self(.recentlyAdded)
	static let recentlyUpdated: Self = Self(.recentlyUpdated)

	static let all: Self = [.recentlyAdded, .recentlyUpdated]
}