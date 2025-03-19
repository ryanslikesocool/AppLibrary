public struct DescriptiveLabelElementVisibility: OptionSet {
	public typealias RawValue = UInt8

	public let rawValue: RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension DescriptiveLabelElementVisibility: Sendable { }

// MARK: - Equatable

extension DescriptiveLabelElementVisibility: Equatable { }

// MARK: - Hashable

extension DescriptiveLabelElementVisibility: Hashable { }

// MARK: - Constants

public extension DescriptiveLabelElementVisibility {
	static let title: Self = Self(rawValue: 1 << 0)
	static let description: Self = Self(rawValue: 1 << 1)

	static let all: Self = [.title, .description]
}