@frozen
public struct SFSymbol: RawRepresentable {
	public let rawValue: String

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension SFSymbol: Sendable { }

// MARK: - ExpressibleByStringLiteral

extension SFSymbol: ExpressibleByStringLiteral {
	public init(stringLiteral value: StringLiteralType) {
		self.init(rawValue: value)
	}
}

// MARK: - Constants

public extension SFSymbol {
	static let trash: Self = "trash"
	static let plus: Self = "plus"
	static let ellipsis_circle: Self = "ellipsis.circle"
	static let ellipsis: Self = "ellipsis"
	static let app: Self = "app"
	static let gearShape: Self = "gearshape"
	static let eye: Self = "eye"
	static let arrow_clockwise: Self = "arrow.clockwise"
	static let square_grid_3x3: Self = "square.grid.3x3"
	static let arrow_up_forward: Self = "arrow.up.forward"
	static let eye_slash: Self = "eye.slash"
	static let exclamationMark_octagon: Self = "exclamationmark.octagon"
	static let gear: Self = "gear"
	static let externalDrive: Self = "externaldrive"
}
