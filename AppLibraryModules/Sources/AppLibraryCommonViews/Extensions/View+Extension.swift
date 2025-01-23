import SwiftUI

// MARK: - shadow

public extension View {
	/// - Parameter shadow:
	func shadow(
		_ shadow: borrowing Shadow
	) -> some View {
		self.shadow(
			color: shadow.color,
			radius: shadow.radius,
			x: shadow.x,
			y: shadow.y
		)
	}
}

// MARK: - overlay

public extension View {
	/// - Parameters:
	///   - stroke:
	///   - shape:
	///   - fillStyle:
	func overlay(
		_ stroke: borrowing Stroke,
		in shape: some InsettableShape,
		fillStyle: FillStyle = FillStyle()
	) -> some View {
		overlay(
			stroke.shapeStyle,
			in: shape
				.inset(by: stroke.strokeStyle.lineWidth * stroke.position.insetMultiplier)
				.stroke(style: stroke.strokeStyle),
			fillStyle: fillStyle
		)
	}
}

// MARK: - background

public extension View {
	/// - Parameters:
	///   - stroke:
	///   - shape:
	///   - fillStyle:
	func background(
		_ stroke: borrowing Stroke,
		in shape: some InsettableShape,
		fillStyle: FillStyle = FillStyle()
	) -> some View {
		background(
			stroke.shapeStyle,
			in: shape
				.inset(by: stroke.strokeStyle.lineWidth * stroke.position.insetMultiplier)
				.stroke(style: stroke.strokeStyle),
			fillStyle: fillStyle
		)
	}
}

// MARK: - draggable

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
