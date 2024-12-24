import AppLibraryStorage

public extension ApplicationModelIdentifier {
	init(_ model: ApplicationModel) {
		self.init(bundleIdentifier: model.bundleIdentifier)
	}

	init(_ instanceIdentifier: borrowing ApplicationInstanceIdentifier) {
		self.init(bundleIdentifier: instanceIdentifier.bundleIdentifier)
	}
}
