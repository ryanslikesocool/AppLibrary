import OSLog
import AppLibraryCommon

extension Logger {
	static let appLibraryBrowser: Logger = Logger(subsystem: Self.appLibrarySubsystem, category: "browser")
}
