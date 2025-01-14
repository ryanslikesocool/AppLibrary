import AppLibraryCommon

public extension AdditionalApplicationGroup {
	/// An efficient set of ``AdditionalApplicationGroup``.
	typealias Set = EnumOptionSet<Self>
}

// MARK: - Constants

public extension AdditionalApplicationGroup.Set {
	/// ## See Also
	/// - ``AdditionalApplicationGroup/recentlyAdded``
	static let recentlyAdded: Self = Self(.recentlyAdded)

	/// ## See Also
	/// - ``AdditionalApplicationGroup/recentlyUpdated``
	static let recentlyUpdated: Self = Self(.recentlyUpdated)
}
