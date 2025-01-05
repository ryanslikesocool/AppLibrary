import AppKit
import SwiftUI

// MARK: - CaseIterable

#if DEBUG
extension EventModifiers: @retroactive CaseIterable {
	public static let allCases: [Self] = [
		.capsLock,
		.shift,
		.control,
		.option,
		.command,
		.numericPad,
//		.function
	]
}
#endif

// MARK: - CustomStringConvertible

#if DEBUG
extension EventModifiers: @retroactive CustomStringConvertible {
	private var elementDescription: String {
		switch self {
			case .capsLock: ".capsLock"
			case .shift: ".shift"
			case .control: ".control"
			case .option: ".option"
			case .command: ".command"
			case .numericPad: ".numericPad"
//			case .function: ".function"
			default:
				enumerated()
					.map(\.element.elementDescription)
					.joined(separator: ", ")
		}
	}

	public var description: String {
		if enumerated().count == 1 {
			"\(Self.self)\(elementDescription)"
		} else {
			"\(Self.self)(\(elementDescription))"
		}
	}
}
#endif

// MARK: -

public extension EventModifiers {
	init(_ modifierFlags: NSEvent.ModifierFlags) {
		let modifierFlags = modifierFlags.intersection(.deviceIndependentFlagsMask)

		assert(notPresent: .help, in: modifierFlags, convertingTo: Self.self)
		assert(notPresent: .function, in: modifierFlags, convertingTo: Self.self)

		self.init(rawValue: RawValue(modifierFlags.rawValue >> bitOffset_EventModifiers_NSEventModifierFlags))
	}
}

public extension NSEvent.ModifierFlags {
	init(_ eventModifiers: EventModifiers) {
		// Workaround to silence `EventModifiers.function` deprecation warning.
		let functionModifier = EventModifiers(rawValue: Int(NSEvent.ModifierFlags.function.rawValue >> (bitOffset_EventModifiers_NSEventModifierFlags + 1)))
		assert(notPresent: functionModifier, in: eventModifiers, convertingTo: Self.self)

		self.init(rawValue: RawValue(eventModifiers.rawValue << bitOffset_EventModifiers_NSEventModifierFlags))
	}
}

// MARK: -

private let bitOffset_EventModifiers_NSEventModifierFlags: Int = 16

private func assert<Input>(
	notPresent argument: Input,
	in input: Input,
	convertingTo targetType: Any.Type,
	file: StaticString = #file,
	line: UInt = #line
) where
	Input: SetAlgebra & RawRepresentable,
	Input.Element == Input
{
	guard !input.contains(argument) else {
		fatalError(
			"The \(Input.self) with raw value \(input.rawValue) does not support being converted to \(targetType).",
			file: file,
			line: line
		)
	}
}
