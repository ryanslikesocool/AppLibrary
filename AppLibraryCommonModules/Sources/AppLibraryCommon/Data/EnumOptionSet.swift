public struct EnumOptionSet<Enum>: OptionSet where
	Enum: RawRepresentable,
	Enum.RawValue: FixedWidthInteger & UnsignedInteger
{
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

extension EnumOptionSet: Encodable where RawValue: Encodable { }

// MARK: - Decodable

extension EnumOptionSet: Decodable where RawValue: Decodable { }

// MARK: - Constants

// public extension EnumBitMask where Enum: CaseIterable {
//	static var all: Self = Enum.allCases.reduce(into: []) { partialResult, element in
//		partialResult.insert(Self(element))
//	}
// }

// MARK: - Convenience

public extension EnumOptionSet {
	init(_ element: Enum) {
		precondition(element.rawValue < Enum.RawValue.bitWidth)

		self.init(rawValue: 1 << element.rawValue)
	}
}
