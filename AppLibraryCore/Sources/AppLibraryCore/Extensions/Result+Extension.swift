private extension Result {
	enum CodingKeys: CodingKey {
		case success
		case failure
	}
}

// MARK: - Sendable

//extension Result: Sendable where Success: Sendable, Failure: Sendable { }

// MARK: - Encodable

extension Result: @retroactive Encodable where Success: Encodable, Failure: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		switch self {
			case let .success(value):
				try container.encode(value, forKey: .success)
			case let .failure(value):
				try container.encode(value, forKey: .failure)
		}
	}
}

// MARK: - Decodable

extension Result: @retroactive Decodable where Success: Decodable, Failure: Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		var allKeys = ArraySlice(container.allKeys)

		guard
			let onlyKey = allKeys.popFirst(),
			allKeys.isEmpty
		else {
			throw DecodingError.typeMismatch(
				Self.self,
				DecodingError.Context(
					codingPath: container.codingPath,
					debugDescription: "Invalid number of keys found, expected one.",
					underlyingError: nil
				)
			)
		}

		self = switch onlyKey {
			case .success:
				try Self.success(container.decode(Success.self, forKey: onlyKey))
			case .failure:
				try Self.failure(container.decode(Failure.self, forKey: onlyKey))
		}
	}
}
