public enum AdditionalApplicationGroup: UInt8 {
	case recentlyAdded
	case recentlyUpdated
}

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
