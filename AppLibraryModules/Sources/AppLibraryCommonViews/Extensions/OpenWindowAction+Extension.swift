import AppLibraryCommon
import SwiftUI

public extension OpenWindowAction {
	/// Opens a window that’s associated with the specified identifier.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`openWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/openwindow )
	/// action with an identifier:
	/// ```swift
	/// openWindow(id: .message)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameter id: The identifier of the scene to present.
	@available(iOS 16, macCatalyst 16, macOS 13, visionOS 1, *)
	@MainActor @preconcurrency
	func callAsFunction(id: WindowIdentifier) {
		callAsFunction(id: id.rawValue)
	}

	/// Opens a window defined by the window group that presents the specified value type and that’s associated with the specified identifier.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`openWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/openwindow )
	/// action with an identifier and a value:
	/// ```swift
	/// openWindow(id: .message, value: message.id)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameters:
	///   - id: The identifier of the scene to present.
	///   - value: The value to present.
	@available(iOS 16, macCatalyst 16, macOS 13, visionOS 1, *)
	@MainActor @preconcurrency
	func callAsFunction<D>(id: WindowIdentifier, value: D) where
		D: Decodable,
		D: Encodable,
		D: Hashable
	{
		callAsFunction(id: id.rawValue, value: value)
	}

	/// Opens a window that’s associated with the specified identifier, using the specified sharing `sharingBehavior`.
	///
	/// If `sharingBehavior` is requested or required, the window is shared if there is an available `sharingSession` and the person using your app confirms the offer to share.
	/// If `sharingBehavior` is requested and the window is not shared, it is opened normally.
	/// If `sharingBehavior` is required and the window is not shared, it is not opened, and an error is thrown.
	/// Regardless of `sharingBehavior`, an error is thrown if the window fails to open.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`openWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/openwindow )
	/// action with an identifier and a sharing behavior:
	/// ```swift
	/// try await openWindow(id: .message, sharingBehavior: .requested)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameters:
	///   - id: The identifier of the scene to present.
	///   - sharingBehavior: The sharing behavior for the opened window.
	@available(macOS 15, *)
	@MainActor
	func callAsFunction(id: WindowIdentifier, sharingBehavior: SharingBehavior) async throws {
		try await callAsFunction(id: id.rawValue, sharingBehavior: sharingBehavior)
	}

	/// Opens a window defined by the window group that presents the specified value type and that’s associated with the specified identifier, using the specified `sharingBehavior`.
	///
	/// If `sharingBehavior` is requested or required, the window is shared if there is an available `sharingSession` and the person using your app confirms the offer to share.
	/// If `sharingBehavior` is requested and the window is not shared, it is opened normally.
	/// If `sharingBehavior` is required and the window is not shared, it is not opened, and an error is thrown.
	/// Regardless of `sharingBehavior`, an error is thrown if the window fails to open.
	///
	/// Don’t call this method directly. SwiftUI calls it when you call the
	/// [`openWindow`]( https://developer.apple.com/documentation/swiftui/environmentvalues/openwindow )
	/// action with an identifier, a value, and a sharing behavior:
	/// ```swift
	/// try await openWindow(id: .message, value: message.id, sharingBehavior: .required)
	/// ```
	///
	/// For information about how Swift uses the `callAsFunction()` method to simplify call site syntax, see
	/// [Methods with Special Names]( https://docs.swift.org/swift-book/documentation/the-swift-programming-language/declarations/#Methods-with-Special-Names )
	/// in *The Swift Programming Language*.
	///
	/// - Parameters:
	///   - id: The identifier of the scene to present.
	///   - value: The value to present.
	///   - sharingBehavior: The sharing behavior for the opened window.
	@available(macOS 15, *)
	@MainActor
	func callAsFunction<D>(id: WindowIdentifier, value: D, sharingBehavior: SharingBehavior) async throws where
		D: Decodable,
		D: Encodable,
		D: Hashable
	{
		try await callAsFunction(id: id.rawValue, value: value, sharingBehavior: sharingBehavior)
	}
}
