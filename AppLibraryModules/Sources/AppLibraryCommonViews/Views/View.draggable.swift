import SwiftUI

public extension View {
	/// Activates this view as the source of a drag and drop operation.
	///
	/// - Remark: This function is an overload for
	/// [`draggable(_:)`]( https://developer.apple.com/documentation/swiftui/view/draggable(_:) )
	/// that accepts an optional `payload`.
	///
	/// - Parameter payload: A closure that returns a single class instance or a value conforming to
	///   [`Transferable`]( https://developer.apple.com/documentation/coretransferable/transferable )
	///   that represents the draggable data from this view.
	/// - Returns: A view that activates this view as the source of a drag and drop operation, beginning with user gesture input.
	@ViewBuilder
	nonisolated func draggable<T>(
		_ payload: T?
	) -> some View where
		T: Transferable
	{
		if let payload {
			draggable(payload)
		} else {
			self
		}
	}

	/// Activates this view as the source of a drag and drop operation.
	///
	/// - Remark: This function is an overload for
	/// [`draggable(_:preview:)`]( https://developer.apple.com/documentation/swiftui/view/draggable(_:preview:) )
	/// that accepts an optional `payload`.
	///
	/// - Parameters:
	///   - payload: A closure that returns a single class instance or a value conforming to
	///   [`Transferable`]( https://developer.apple.com/documentation/coretransferable/transferable )
	///   that represents the draggable data from this view.
	///   - preview: A
	///   [`View`]( https://developer.apple.com/documentation/swiftui/view )
	///   to use as the source for the dragging preview, once the drag operation has begun.
	///   The preview is centered over the source view.
	/// - Returns: A view that activates this view as the source of a drag and drop operation, beginning with user gesture input.
	@ViewBuilder
	nonisolated func draggable<T, V>(
		_ payload: T?,
		@ViewBuilder preview: () -> V
	) -> some View where
		T: Transferable,
		V: View
	{
		if let payload {
			draggable(payload, preview: preview)
		} else {
			self
		}
	}
}
