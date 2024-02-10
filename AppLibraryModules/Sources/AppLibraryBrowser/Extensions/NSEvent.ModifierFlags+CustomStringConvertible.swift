import AppKit

extension NSEvent.ModifierFlags: CustomStringConvertible {
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
			default: enumerated().map(\.description).joined(separator: ", ")
		}
	}
}
