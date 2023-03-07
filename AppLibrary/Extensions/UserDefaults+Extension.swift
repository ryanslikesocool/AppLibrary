import Foundation

extension UserDefaults {
	typealias Key = String
}

extension UserDefaults.Key {
	static let bookmarkData: Self = "bookmarkData"

	static let hiddenApps: Self = "hiddenApps"

	static let columns: Self = "columns"
	static let sizeClass: Self = "sizeClass"
	static let spacing: Self = "spacing"
	static let padding: Self = "padding"
}
