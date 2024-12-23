import AppKit

// MARK: - CustomStringConvertible

#if DEBUG
extension NSEvent.ModifierFlags: @retroactive CustomStringConvertible {
	public var description: String {
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
					.map(\.element.description)
					.joined(separator: ", ")
		}
	}
}
#endif

// MARK: - CaseIterable

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