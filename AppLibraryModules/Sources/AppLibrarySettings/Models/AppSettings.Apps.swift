public extension AppSettings {
	struct Apps: Hashable { }
}

// MARK: - Codable

extension AppSettings.Apps: Codable { }

// MARK: - SettingsFile

extension AppSettings.Apps: SettingsFile {
	static let fileName: String = "apps.plist"

	func prepare() { }
}
