public struct ApplicationConfiguration {
	public var visibilityFlags: ApplicationVisibility.Set

	public init(
		visibilityFlags: ApplicationVisibility.Set
	) {
		self.visibilityFlags = visibilityFlags
	}

	public init() {
		visibilityFlags = .all
	}
}

// MARK: - Sendable

extension ApplicationConfiguration: Sendable { }

// MARK: - Equatable

extension ApplicationConfiguration: Equatable { }

// MARK: - Hashable

extension ApplicationConfiguration: Hashable { }

// MARK: - Codable

// NOTE: Implement `Codable` manually since values may change in the future.

extension ApplicationConfiguration: Codable {
	private enum CodingKeys: CodingKey {
		case visibilityFlags
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		self.init()

		// NOTE: Use `decodeIfPresent` when possible to avoid issues when adding new settings.

		visibilityFlags = try container.decodeIfPresent(ApplicationVisibility.Set.self, forKey: .visibilityFlags) ?? visibilityFlags
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(visibilityFlags, forKey: .visibilityFlags)
	}
}
