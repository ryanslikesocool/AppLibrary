@frozen
public struct BundleIdentifier: RawRepresentable {
	public typealias RawValue = String

	public let rawValue: RawValue

	public init?(rawValue: RawValue) {
		guard rawValue.wholeMatch(of: Self.validRawValueRegex) != nil else {
			return nil
		}

		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension BundleIdentifier: Sendable { }

// MARK: - Equatable

extension BundleIdentifier: Equatable { }

// MARK: - Hashable

extension BundleIdentifier: Hashable { }

// MARK: - Codable

extension BundleIdentifier: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		rawValue = try container.decode(RawValue.self)
		// TODO: perform validation
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

// MARK: - Constants

private extension BundleIdentifier {
	nonisolated(unsafe) static let validRawValueRegex = /[\w\d]+[\w\d\-.]*[\w\d]+/
}

// MARK: - Convenience

public extension BundleIdentifier {
	@inlinable
	init?(_ rawValue: String) {
		self.init(rawValue: rawValue)
	}

	init?(_ rawValue: String?) {
		guard let rawValue else {
			return nil
		}
		self.init(rawValue: rawValue)
	}
}
