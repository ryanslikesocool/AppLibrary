import Foundation

final class AppSettings: ObservableObject {
	static let shared: AppSettings = .load()

	@Published var display: Display
	@Published var directories: Directories

	private init() {
		display = Display()
		directories = Directories()
	}

	static func save() {
		shared.save()
	}

	private func prepare() {
		display.appearance.apply()
	}
}

// MARK: - Hashable

extension AppSettings: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(display)
		hasher.combine(directories)
	}

	static func == (lhs: AppSettings, rhs: AppSettings) -> Bool {
		lhs.hashValue == rhs.hashValue
	}
}

// MARK: - Codable

extension AppSettings: Codable {
	private enum CodingKeys: CodingKey {
		case display
		case directories
	}

	convenience init(from decoder: Decoder) throws {
		self.init()

		let container = try decoder.container(keyedBy: CodingKeys.self)

		display = try container.decodeIfPresent(forKey: .display) ?? display
		directories = try container.decodeIfPresent(forKey: .directories) ?? directories
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encode(display, forKey: .display)
		try container.encode(directories, forKey: .directories)
	}
}

// MARK: - Storage

private extension AppSettings {
	private static var fileURL: URL { URL.applicationSupportDirectory.appendingPathComponent("\(Bundle.main.bundleIdentifier!)/settings.plist", isDirectory: false) }

	static func load() -> AppSettings {
		let result: AppSettings = load(url: fileURL) ?? AppSettings()
		result.prepare()
		return result
	}

	private static func load(url: URL) -> AppSettings? {
		do {
			let data = try Data(contentsOf: url)
			return try load(data: data)
		} catch {
			return nil
		}
	}

	private static func load(data: Data) throws -> AppSettings {
		let decoder = PropertyListDecoder()
		return try decoder.decode(Self.self, from: data)
	}

	func save() {
		save(to: Self.fileURL)
	}

	private func save(to url: URL) {
		let fileManager = FileManager.default

		do {
			var isDirectory: ObjCBool = true
			let folder = url.deletingLastPathComponent()
			if !fileManager.fileExists(atPath: folder.path, isDirectory: &isDirectory) {
				try fileManager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
			}

			if !fileManager.fileExists(atPath: url.path) {
				fileManager.createFile(atPath: url.path, contents: nil, attributes: nil)
			}

			let encoder = PropertyListEncoder()
			let data = try encoder.encode(self)

			try data.write(to: url)
		} catch {
			print("Couldn't save file to \(url)", error)
		}
	}
}
