import OSLog
import AppLibraryCommon

extension Logger {
	static let module: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "Settings")
}
