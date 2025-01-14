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

// MARK: - Identifiable

extension AdditionalApplicationGroup: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension AdditionalApplicationGroup: Codable { }

// MARK: - CaseIterable

extension AdditionalApplicationGroup: CaseIterable { }
