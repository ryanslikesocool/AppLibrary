/// A wrapper around a `Hashable` value, so it can act as its own identifier without requiring conformance to `Identifiable`.
@propertyWrapper
public struct Identifier<Value> where
	Value: Hashable
{
	public var wrappedValue: Value

	public var projectedValue: Self { self }

	public init(wrappedValue: Value) {
		self.wrappedValue = wrappedValue
	}

	public init(_ wrappedValue: Value) {
		self.init(wrappedValue: wrappedValue)
	}
}

// MARK: - Sendable

extension Identifier: Sendable where Value: Sendable { }

// MARK: - Equatable

extension Identifier: Equatable { }

// MARK: - Hashable

extension Identifier: Hashable { }

// MARK: - Identifiable

extension Identifier: Identifiable {
	public var id: Value { wrappedValue }
}

// MARK: - Codable

extension Identifier: Codable where Value: Codable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(wrappedValue: container.decode(Value.self))
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(wrappedValue)
	}
}
