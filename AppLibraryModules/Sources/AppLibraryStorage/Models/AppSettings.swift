import AppLibraryCommon
import Foundation

public final class AppSettings: ObservableObject {
	public static let shared: AppSettings = AppSettings()

	@Published public var display: Display
	@Published public var layout: Layout
	@Published public var discovery: Discovery
	@Published public var apps: Apps

	private init() {
		display = Display(directory: Self.directoryURL) ?? Display()
		layout = Layout(directory: Self.directoryURL) ?? Layout()
		discovery = Discovery(directory: Self.directoryURL) ?? Discovery()
		apps = Apps(directory: Self.directoryURL) ?? Apps()
	}
}

// MARK: - Equatable

extension AppSettings: Equatable {
	public static func == (lhs: AppSettings, rhs: AppSettings) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

// MARK: - Hashable

extension AppSettings: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(display)
		hasher.combine(layout)
		hasher.combine(discovery)
		hasher.combine(apps)
	}
}

// MARK: - Constants

extension AppSettings {
	static var directoryURL: URL { URL.applicationSupportDirectory.appending(path: AppLibraryInformation.appName, directoryHint: .isDirectory) }

	static let plistDecoder: PropertyListDecoder = PropertyListDecoder()

	static let plistEncoder: PropertyListEncoder = {
		let encoder = PropertyListEncoder()
		encoder.outputFormat = .xml
		return encoder
	}()
}

// MARK: -

public extension AppSettings {
	func prepare() {
		display.prepare()
		layout.prepare()
		discovery.prepare()
		apps.prepare()
	}
}
