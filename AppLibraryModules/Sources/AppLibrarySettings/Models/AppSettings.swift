import AppLibraryCommon
import Foundation

public final class AppSettings: ObservableObject {
	public static let shared: AppSettings = AppSettings()

	@Published public var display: Display
	@Published public var directories: Directories
	@Published public var apps: Apps

	private init() {
		display = Display(directory: Self.directoryURL) ?? Display()
		directories = Directories(directory: Self.directoryURL) ?? Directories()
		apps = Apps(directory: Self.directoryURL) ?? Apps()
	}
}

// MARK: - Hashable

extension AppSettings: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(display)
		hasher.combine(directories)
		hasher.combine(apps)
	}

	public static func == (lhs: AppSettings, rhs: AppSettings) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

// MARK: - Constants

extension AppSettings {
	static let directoryURL: URL = URL.applicationSupportDirectory.appending(path: AppLibraryInformation.bundleIdentifier, directoryHint: .isDirectory)

	static let plistDecoder: PropertyListDecoder = PropertyListDecoder()

	static let plistEncoder: PropertyListEncoder = {
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .xml
		return encoder
	}()
}

// MARK: - Supporting

public extension AppSettings {
	func prepare() {
		display.prepare()
		directories.prepare()
		apps.prepare()
	}
}
