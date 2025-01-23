import AppLibraryCommon
import SwiftUI

@available(iOS 17.0, macOS 14.0, visionOS 1.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public extension DismissWindowAction {
	/// Dismisses the window that’s associated with the specified identifier.
	///
	/// When the specified identifier represents a
	/// [`WindowGroup`]( https://developer.apple.com/documentation/swiftui/windowgroup ),
	/// all of the open windows in that group will be dismissed.
	/// For dismissing a single window associated to a `WindowGroup` scene, use `dismissWindow(value:)` or `dismissWindow(id:value:)`.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`dismissWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/dismisswindow )
	/// action with an identifier:
	/// ```swift
	/// dismissWindow(id: .message)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameter id: The identifier of the scene to dismiss.
	@MainActor @preconcurrency
	func callAsFunction(id: WindowIdentifier) {
		callAsFunction(id: id.rawValue)
	}

	/// Dismisses the window defined by the window group that is presenting the specified value type and that’s associated with the specified identifier.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`dismissWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/dismisswindow )
	/// action with an identifier:
	/// ```swift
	/// dismissWindow(id: .message, value: message.id)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameters:
	///   - id: The identifier of the scene to dismiss.
	///   - value: The value which is currently presented.
	@MainActor @preconcurrency
	func callAsFunction<D>(id: WindowIdentifier, value: D) where
		D: Decodable,
		D: Encodable,
		D: Hashable
	{
		callAsFunction(id: id.rawValue, value: value)
	}
}
