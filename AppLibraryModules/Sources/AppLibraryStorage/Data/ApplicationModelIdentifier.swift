public struct ApplicationModelIdentifier {
	public let bundleIdentifier: String

	public init(bundleIdentifier: String) {
		self.bundleIdentifier = bundleIdentifier
	}
}

// MARK: - Sendable

extension ApplicationModelIdentifier: Sendable { }

// MARK: - Equatable

extension ApplicationModelIdentifier: Equatable { }

// MARK: - Hashable

extension ApplicationModelIdentifier: Hashable { }

// MARK: - Identifiable

extension ApplicationModelIdentifier: Identifiable {
	public var id: String { bundleIdentifier }
}

// MARK: - Codable

extension ApplicationModelIdentifier: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(bundleIdentifier: container.decode(String.self))
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(bundleIdentifier)
	}
}

// MARK: - CustomStringConvertible

extension ApplicationModelIdentifier: CustomStringConvertible {
	public var description: String {
		"\(Self.self)(bundleIdentifier: \(bundleIdentifier))"
	}
}

// MARK: - Convenience

extension ApplicationModelIdentifier {
	public init(_ model: ApplicationModel) {
		self.init(bundleIdentifier: model.bundleIdentifier)
	}

	init(_ instanceIdentifier: borrowing ApplicationInstanceIdentifier) {
		self.init(bundleIdentifier: instanceIdentifier.bundleIdentifier)
	}
}
