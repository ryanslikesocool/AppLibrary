import Combine

@MainActor
@propertyWrapper
public final class ObservingCurrentValue<Output>: ObservableObject {
	@Published
	public var wrappedValue: Output

	public var projectedValue: ObservingCurrentValue<Output> {
		self
	}

	public var publisher: some Publisher<Output, Never> {
		$wrappedValue
	}

	public init(wrappedValue: Output) {
		self.wrappedValue = wrappedValue
	}
}
