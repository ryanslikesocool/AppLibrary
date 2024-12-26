import AppKit

// MARK: - CaseIterable

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

#if DEBUG
extension NSEvent.ModifierFlags: @retroactive CustomStringConvertible {
	public var description: String {
		switch self {
			case .capsLock: "\(Self.self).capsLock"
			case .shift: "\(Self.self).shift"
			case .control: "\(Self.self).control"
			case .option: "\(Self.self).option"
			case .command: "\(Self.self).command"
			case .numericPad: "\(Self.self).numericPad"
			case .help: "\(Self.self).help"
			case .function: "\(Self.self).function"
			default:
				enumerated()
					.map(\.element.description)
					.joined(separator: ", ")
		}
	}
}
#endif