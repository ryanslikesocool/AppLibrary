import AppKit

// MARK: - CaseIterable

// NOTE: This extension is used for debugging
// and isn't needed for release builds.

#if DEBUG
extension NSEvent.ModifierFlags: @retroactive CaseIterable {
	public static let allCases: [NSEvent.ModifierFlags] = [
		.capsLock,
		.shift,
		.control,
		.option,
		.command,
		.numericPad,
		.help,
		.function,
	]
}
#endif

// MARK: - CustomStringConvertible

// NOTE: This extension is used for debugging
// and isn't needed for release builds.

#if DEBUG
extension NSEvent.ModifierFlags: @retroactive CustomStringConvertible {
	private var elementDescription: String {
		switch self {
			case .capsLock: "capsLock"
			case .shift: "shift"
			case .control: "control"
			case .option: "option"
			case .command: "command"
			case .numericPad: "numericPad"
			case .help: "help"
			case .function: "function"
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
