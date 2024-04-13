import OSLog

public extension Logger {
	static var appLibrarySubsystem: String { AppLibraryInformation.bundleIdentifier }
}
