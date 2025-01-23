import Combine

private extension Publishers {
	static func _combineLatest<P: Publisher>(
		_ first: P,
		_ second: P,
		_ rest: borrowing some Swift.Sequence<P>,
		output: P.Output.Type = P.Output.self,
		failure: P.Failure.Type = P.Failure.self
	) -> AnyPublisher<[P.Output], P.Failure> {
		rest.reduce(
			Publishers
				.CombineLatest(first, second)
				.map { [$0.0, $0.1] }
				.eraseToAnyPublisher())
		{ result, element in
			Publishers.CombineLatest(result, element)
				.map { $0.0 + [$0.1] }
				.eraseToAnyPublisher()
		}
	}
}

// MARK: - Array

public extension Publishers {
	/// Combine multiple publishers using ``Combine/Publishers/CombineLatest``.
	/// - Parameter publishers: The publishers to combine.
	/// - Returns: A new publisher, or `nil` if the provided array was empty.
	static func combineLatest<P: Publisher>(
		_ publishers: borrowing [P],
		output: P.Output.Type = P.Output.self,
		failure: P.Failure.Type = P.Failure.self
	) -> AnyPublisher<[P.Output], P.Failure>? {
		switch publishers.count {
			case 0: nil
			case 1: publishers[0].map { [$0] }.eraseToAnyPublisher()
			default: _combineLatest(publishers[0], publishers[1], publishers[2...])
		}
	}

	/// Combine multiple publishers using ``Combine/Publishers/CombineLatest``.
	/// - Parameter publishers: The publishers to combine.
	/// - Returns: A new publisher, or `nil` if the provided collection was empty.
	@_disfavoredOverload
	static func combineLatest<P: Publisher>(
		_ publishers: borrowing [P],
		failure: P.Failure.Type = P.Failure.self
	) -> (some Publisher<P.Output, P.Failure>)?
		where P.Output == Void
	{
		combineLatest(
			publishers,
			output: P.Output.self,
			failure: P.Failure.self
		)?.map { _ in }
			.eraseToAnyPublisher()
	}
}

// MARK: - Sequence

public extension Publishers {
	/// Combine multiple publishers using ``Combine/Publishers/CombineLatest``.
	/// - Parameter publishers: The publishers to combine.
	/// - Returns: A new publisher, or `nil` if the provided sequence was empty.
	static func combineLatest<P: Publisher>(
		_ publishers: some Swift.Sequence<P>,
		output: P.Output.Type = P.Output.self,
		failure: P.Failure.Type = P.Failure.self
	) -> (some Publisher<[P.Output], P.Failure>)? {
		combineLatest(
			Array(publishers),
			output: output,
			failure: failure
		)
	}

	/// Combine multiple publishers using ``Combine/Publishers/CombineLatest``.
	/// - Parameter publishers: The publishers to combine.
	/// - Returns: A new publisher, or `nil` if the provided collection was empty.
	@_disfavoredOverload
	static func combineLatest<P: Publisher>(
		_ publishers: some Swift.Sequence<P>,
		failure: P.Failure.Type = P.Failure.self
	) -> (some Publisher<P.Output, P.Failure>)?
		where P.Output == Void
	{
		combineLatest(
			Array(publishers),
			failure: failure
		)
	}
}

// MARK: - Variadic

public extension Publishers {
	/// Combine multiple publishers using ``Combine/Publishers/CombineLatest``.
	/// - Parameter publishers: The publishers to combine.
	/// - Returns: A new publisher, or `nil` if the provided array was empty.
	static func combineLatest<P: Publisher>(
		_ first: borrowing P, _ second: borrowing P, _ rest: P...,
		output: P.Output.Type = P.Output.self,
		failure: P.Failure.Type = P.Failure.self
	) -> some Publisher<[P.Output], P.Failure> {
		_combineLatest(
			first, second, rest,
			output: output,
			failure: failure
		)
	}

	static func combineLatest<P: Publisher>(
		_ first: borrowing P, _ second: borrowing P, _ rest: P...,
		output: P.Output.Type = P.Output.self,
		failure: P.Failure.Type = P.Failure.self
	) -> some Publisher<P.Output, P.Failure>
		where P.Output == Void
	{
		_combineLatest(
			first, second, rest,
			output: output,
			failure: failure
		).map { _ in }
	}
}
