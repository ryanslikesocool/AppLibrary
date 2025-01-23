import Combine

public extension Publisher<
	(WindowIdentifier, WindowVisibilityMessage),
	Never
> {
	func filter(
		windowIdentifier expectingWindowIdentifier: WindowIdentifier
	) -> Publishers.Filter<
		some Publisher<
			(WindowIdentifier, WindowVisibilityMessage),
			Never
		>
	> {
		filter { windowIdentifier, _ in
			windowIdentifier == expectingWindowIdentifier
		}
	}
}
