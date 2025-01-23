/// ## See Also
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update.
///   - newValue:
///   - condition:
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
@discardableResult
public func updating<Value>(
	_ currentValue: inout Value,
	with newValue: Value,
	condition: (Value, Value) throws -> Bool
) rethrows -> Bool {
	guard try condition(currentValue, newValue) else {
		return false
	}
	currentValue = newValue
	return true
}

/// ## See Also
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update.
///   - newValue:
///   - condition:
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
// NOTE: This function is disfavored over the function that receives a non-optional `newValue`.
@_disfavoredOverload
@discardableResult
public func updating<Value>(
	_ currentValue: inout Value,
	with newValue: Value?,
	condition: (Value, Value) throws -> Bool
) rethrows -> Bool {
	guard let newValue else {
		return false
	}
	return try updating(&currentValue, with: newValue, condition: condition)
}

/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update.
///   - newValue:
///   - condition:
///   - transform: A transformation to apply to the `newValue` to convert it to the `currentValue` type.
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
@discardableResult
public func updating<Input, Output>(
	_ currentValue: inout Output,
	with newValue: Input,
	condition: (Output, Output) throws -> Bool,
	transform: (Input) throws -> Output
) rethrows -> Bool {
	let newValue = try transform(newValue)
	return try updating(
		&currentValue,
		with: newValue,
		condition: condition
	)
}

/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update.
///   - newValue:
///   - condition:
///   - transform: A transformation to apply to the `newValue` to convert it to the `currentValue` type.
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
// NOTE: This function is disfavored over the function that receives a non-optional `newValue`.
@_disfavoredOverload
@discardableResult
public func updating<Input, Output>(
	_ currentValue: inout Output,
	with newValue: Input?,
	condition: (Output, Output) throws -> Bool,
	transform: (Input) throws -> Output
) rethrows -> Bool {
	guard let newValue else {
		return false
	}
	return try updating(&currentValue, with: newValue, condition: condition, transform: transform)
}

// MARK: - Equatable

/// ## Discussion
///
/// Use ``updating(_:with:condition:)`` to declare a custom condition for the update.
///
/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update if it is not equal to the `newValue`.
///   - newValue:
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
@discardableResult
public func updating<Value>(
	_ currentValue: inout Value,
	with newValue: Value
) -> Bool where
	Value: Equatable
{
	updating(
		&currentValue,
		with: newValue
	) { currentValue, newValue in
		currentValue != newValue
	}
}

/// ## Discussion
///
/// Use ``updating(_:with:condition:)`` to declare a custom condition for the update.
///
/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:transform:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update if it is not equal to the `newValue`.
///   - newValue:
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
// NOTE: This function is disfavored over the function that receives a non-optional `newValue`.
@_disfavoredOverload
@discardableResult
public func updating<Value>(
	_ currentValue: inout Value,
	with newValue: Value?
) -> Bool where
	Value: Equatable
{
	updating(
		&currentValue,
		with: newValue
	) { currentValue, newValue in
		currentValue != newValue
	}
}

/// ## Discussion
///
/// Use ``updating(_:with:condition:transform:)`` to declare a custom condition for the update.
///
/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update if it is not equal to the `newValue`.
///   - newValue:
///   - transform: A transformation to apply to the `newValue` to convert it to the `currentValue` type.
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
@discardableResult
public func updating<Input, Output>(
	_ currentValue: inout Output,
	with newValue: Input,
	transform: (Input) throws -> Output
) rethrows -> Bool where
	Output: Equatable
{
	try updating(
		&currentValue,
		with: newValue,
		condition: { currentValue, newValue in
			currentValue != newValue
		},
		transform: transform
	)
}

/// ## Discussion
///
/// Use ``updating(_:with:condition:transform:)`` to declare a custom condition for the update.
///
/// ## See Also
/// - ``updating(_:with:condition:)``
/// - ``updating(_:with:condition:transform:)``
/// - ``updating(_:with:)``
///
/// - Parameters:
///   - currentValue: The current value to attempt to update if it is not equal to the `newValue`.
///   - newValue:
///   - transform: A transformation to apply to the `newValue` to convert it to the `currentValue` type.
/// - Returns: `true` if the `currentValue` was changed; `false` otherwise.
// NOTE: This function is disfavored over the function that receives a non-optional `newValue`.
@_disfavoredOverload
@discardableResult
public func updating<Input, Output>(
	_ currentValue: inout Output,
	with newValue: Input?,
	transform: (Input) throws -> Output
) rethrows -> Bool where
	Output: Equatable
{
	try updating(
		&currentValue,
		with: newValue,
		condition: { currentValue, newValue in
			currentValue != newValue
		},
		transform: transform
	)
}
