import AppLibraryCommon
import OSLog

extension Logger {
	static let module: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "Main")
}
