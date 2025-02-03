import AppLibraryStorage

@propertyWrapper
public struct Application {
	public let wrappedValue: ApplicationModelIdentifier

	@MainActor
	public var projectedValue: ApplicationModel? {
		ApplicationCache.shared.find(withIdentifier: wrappedValue)
	}

	public init(wrappedValue: ApplicationModelIdentifier) {
		self.wrappedValue = wrappedValue
	}
}

// MARK: - Convenience

public extension Application {
	init(_ wrappedValue: ApplicationModelIdentifier) {
		self.init(wrappedValue: wrappedValue)
	}
}
