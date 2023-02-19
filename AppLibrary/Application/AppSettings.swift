import Foundation

struct AppSettings {
	private static let storage: UserDefaults = .standard

	var columns: Int = 3 { didSet { Self.set(columns, for: .columns) } }
	var sizeClass: Int = 2 { didSet { Self.set(sizeClass, for: .sizeClass) } }
	var spacing: Double = 36.0 { didSet { Self.set(spacing, for: .spacing) } }
	var padding: Double = 24.0 { didSet { Self.set(padding, for: .padding) } }

	var iconSize: Double { Double(sizeClass) * 32.0 }

	init() {
		columns = Self.get(for: .columns) ?? columns
		sizeClass = Self.get(for: .sizeClass) ?? sizeClass
		spacing = Self.get(for: .spacing) ?? spacing
		padding = Self.get(for: .padding) ?? padding
	}

	static func get<V>(for key: UserDefaults.Key) -> V? {
		storage.value(forKey: key) as? V
	}

	static func set<T>(_ value: T, for key: UserDefaults.Key) {
		storage.setValue(value, forKey: key)
	}
}