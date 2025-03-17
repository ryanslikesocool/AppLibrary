public protocol EnumOptionSet<Enum>: OptionSet where
	RawValue == Enum.RawValue,
	RawValue: Codable,
	Element == Self
{
	associatedtype Enum: RawRepresentable where
		Enum.RawValue: FixedWidthInteger & UnsignedInteger

	init(rawValue: RawValue)
}

// MARK: - Default Implementation

public extension EnumOptionSet where
	Self: Decodable
{
	init(from decoder: any Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(RawValue.self)
		self.init(rawValue: rawValue)
	}
}

public extension EnumOptionSet where
	Self: Encodable
{
	func encode(to encoder: any Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(rawValue)
	}
}

public extension EnumOptionSet where
	Self: CaseIterable,
	Enum: CaseIterable
{
	static var allCases: [Self] { Enum.allCases.map(Self.init) }
}

// MARK: - Intrinsic

public extension EnumOptionSet {
	init(_ element: Enum) {
		precondition(element.rawValue < RawValue.bitWidth)
		self.init(rawValue: 1 << element.rawValue)
	}

	init(_ elements: some Sequence<Enum>) {
		self = elements.reduce(into: Self(rawValue: RawValue.zero)) { partialResult, element in
			let flag = Self(element)
			partialResult.insert(flag)
		}
	}

	init(_ elements: Enum...) {
		self.init(elements)
	}
}

public extension EnumOptionSet where
	Enum: CaseIterable
{
	var elements: [Enum] {
		Enum.allCases.filter { element in
			let flag = Self(element)
			return self.contains(flag)
		}
	}
}

public extension EnumOptionSet where
	Self: CaseIterable,
	Enum: CaseIterable
{
	static var all: Self {
		Self(Enum.allCases)
	}
}

public extension EnumOptionSet {
	static var none: Self {
		Self(rawValue: RawValue.zero)
	}

	subscript(element: Enum) -> Bool {
		get { self[Self(element)] }
		set { self[Self(element)] = newValue }
	}
}