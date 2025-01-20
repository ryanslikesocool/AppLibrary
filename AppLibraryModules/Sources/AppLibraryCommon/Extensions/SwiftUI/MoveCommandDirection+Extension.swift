import SwiftUI

// MARK: - CaseIterable

extension MoveCommandDirection: @retroactive CaseIterable {
	public static let allCases: [MoveCommandDirection] = [
		.left, .right, .down, .up,
	]
}

// MARK: - Convenience

public extension MoveCommandDirection {
//	init?(keyCode: UInt16) {
//		// TODO: Optimize
//		// - Is the Swift compiler already smart enough to optimize this away?
//		// - Should we store this as a `static let keyCodeInitializerLookupTable: [KeyCode : Self]`?
//		// - Should this be reimplemented as a `switch`?
//		//   - Should `switch` cases be `case Self.<case>.keyCode:` for safety?
//
//		self.init(where: \.keyCode, equals: keyCode)
//	}

	init?(keyEquivalent: KeyEquivalent) {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should we store this as a `static let keyEquivalentInitializerLookupTable: [KeyEquivalent : Self]`?
		// - Should this be reimplemented as a `switch`?
		//   - Should `switch` cases be `case Self.<case>.keyEquivalent:` for safety?

		self.init(where: \.keyEquivalent, equals: keyEquivalent)
	}

	init?(charactersIgnoringModifiersIn nsEvent: NSEvent) {
		guard let keyEquivalent = KeyEquivalent(charactersIgnoringModifiersIn: nsEvent) else {
			return nil
		}
		self.init(keyEquivalent: keyEquivalent)
	}
}

// MARK: - Properties

public extension MoveCommandDirection {
//	var keyCode: UInt16 {
//		switch self {
//			case .left: 0x7B
//			case .right: 0x7C
//			case .down: 0x7D
//			case .up: 0x7E
//			@unknown default: Self.fatalError(unsupportedCase: self)
//		}
//	}

	var keyEquivalent: KeyEquivalent {
		switch self {
			case .left: .leftArrow
			case .right: .rightArrow
			case .down: .downArrow
			case .up: .upArrow
			@unknown default: Self.fatalError(unsupportedCase: self)
		}
	}

	var axis: Axis {
		switch self {
			case .left, .right: .horizontal
			case .down, .up: .vertical
			@unknown default: Self.fatalError(unsupportedCase: self)
		}
	}
}

// MARK: -

package extension MoveCommandDirection {
	// TODO: Should this be removing in favor of returning `nil`?
	/// - Parameters:
	///   - enumerationCase:
	///   - file: The file the error occured in.
	///   By default, this uses the
	///   [`#file`]( https://developer.apple.com/documentation/swift/file() )
	///   macro.
	///   - line: The line the error occured on.
	///   By default, this uses the
	///   [`#line`]( https://developer.apple.com/documentation/swift/line() )
	///   macro.
	static func fatalError(
		unsupportedCase enumerationCase: Self,
		file: StaticString = #file,
		line: UInt = #line
	) -> Never {
		Swift.fatalError(
			"""
			Encountered an unsupported \(Self.self) case `\(enumerationCase)`.
			This should not happen.
			""",
			file: file,
			line: line
		)
	}
}
