public extension AppSettings {
	struct Directories: Hashable { }
}

// MARK: - Codable

extension AppSettings.Directories: Codable { }

// MARK: - SettingsFile

extension AppSettings.Directories: SettingsFile {
	static let fileName: String = "directories.plist"

	func prepare() { }
}
