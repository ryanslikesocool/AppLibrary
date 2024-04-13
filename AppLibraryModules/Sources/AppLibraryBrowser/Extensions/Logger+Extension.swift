import AppLibraryCommon
import OSLog

extension Logger {
	static let module: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "Browser")

	static let keyboardEvents: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "Keyboard Events")
}
