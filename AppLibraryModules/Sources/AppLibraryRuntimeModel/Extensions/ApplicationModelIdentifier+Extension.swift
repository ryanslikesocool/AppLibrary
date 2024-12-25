import AppLibraryStorage

public extension ApplicationModelIdentifier {
	init(_ model: borrowing ApplicationModel) {
		self.init(bundleIdentifier: model.bundleIdentifier)
	}
}
