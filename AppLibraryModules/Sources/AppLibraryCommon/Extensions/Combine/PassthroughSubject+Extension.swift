import Combine

public extension PassthroughSubject {
	/// Sends a value to the subscriber.
	func send<each Input>(_ input: repeat each Input) where
		Output == (repeat each Input)
	{
		send((repeat each input))
	}
}
