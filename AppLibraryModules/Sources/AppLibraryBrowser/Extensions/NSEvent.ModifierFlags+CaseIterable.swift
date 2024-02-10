import AppKit

extension NSEvent.ModifierFlags: CaseIterable {
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
