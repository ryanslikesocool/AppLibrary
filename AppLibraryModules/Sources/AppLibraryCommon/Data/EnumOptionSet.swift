public struct EnumOptionSet<Enum>: OptionSet where
	Enum: RawRepresentable,
	Enum.RawValue: FixedWidthInteger & UnsignedInteger
{
	public typealias Enum = Enum

	public let rawValue: Enum.RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension EnumOptionSet: Sendable where RawValue: Sendable { }

// MARK: - Equatable

extension EnumOptionSet: Equatable { }

// MARK: - Hashable

extension EnumOptionSet: Hashable { }

// MARK: - Encodable

extension EnumOptionSet: Encodable where RawValue: Encodable {
	public func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

// MARK: - Decodable

extension EnumOptionSet: Decodable where RawValue: Decodable {
	public init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		try self.init(rawValue: container.decode(RawValue.self))
	}
}

// MARK: - CaseIterable

extension EnumOptionSet: CaseIterable where Enum: CaseIterable {
	public static var allCases: [Self] { Enum.allCases.map(Self.init) }
}

// MARK: - Convenience

public extension EnumOptionSet {
	init(_ element: Enum) {
		precondition(element.rawValue < Enum.RawValue.bitWidth)

		self.init(rawValue: 1 << element.rawValue)
	}

	init<S>(_ elements: S) where
		S: Sequence,
		S.Element == Enum
	{
		self = elements.reduce(Self.none) { partialResult, element in
			partialResult.union(Self(element))
		}
	}

	init(_ elements: Enum...) {
		self.init(elements)
	}
}

// MARK: - Constants

public extension EnumOptionSet {
	static var none: Self {
		Self(rawValue: RawValue.zero)
	}
}

public extension EnumOptionSet where
	Enum: CaseIterable
{
	// TODO: Should typealiases implement this manually?
	static var all: Self {
		Self(Enum.allCases)
	}
}

// MARK: -

public extension EnumOptionSet where
	Enum: CaseIterable
{
	var elements: [Enum] {
		Enum.allCases
			.filter { item in
				self.contains(Self(item))
			}
	}
}

public extension EnumOptionSet {
	subscript(element: Enum) -> Bool {
		get { self[Self(element)] }
		set { self[Self(element)] = newValue }
	}
}
