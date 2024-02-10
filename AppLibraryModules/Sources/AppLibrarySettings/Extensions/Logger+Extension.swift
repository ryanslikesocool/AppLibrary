import OSLog
import AppLibraryCommon

extension Logger {
	static let appLibrarySettings: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "settings")
}
