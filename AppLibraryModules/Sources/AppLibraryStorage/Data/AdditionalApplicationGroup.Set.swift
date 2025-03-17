import AppLibraryCommon

public extension AdditionalApplicationGroup {
	/// An efficient set of ``AdditionalApplicationGroup``.
	struct Set: EnumOptionSet {
		public typealias Enum = AdditionalApplicationGroup

		public let rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension AdditionalApplicationGroup.Set: Sendable { }

// MARK: - Equatable

extension AdditionalApplicationGroup.Set: Equatable { }

// MARK: - Hashable

extension AdditionalApplicationGroup.Set: Hashable { }

// MARK: - Codable

extension AdditionalApplicationGroup.Set: Codable { }

// MARK: - CaseIterable

extension AdditionalApplicationGroup.Set: CaseIterable { }

// MARK: - Constants

public extension AdditionalApplicationGroup.Set {
	/// ## See Also
	/// - ``AdditionalApplicationGroup/recentlyAdded``
	static let recentlyAdded: Self = Self(.recentlyAdded)

	/// ## See Also
	/// - ``AdditionalApplicationGroup/recentlyUpdated``
	static let recentlyUpdated: Self = Self(.recentlyUpdated)
}
