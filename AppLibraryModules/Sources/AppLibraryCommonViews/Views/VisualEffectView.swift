import AppKit
import AppLibraryCommon
import SwiftUI

public struct VisualEffectView: NSViewRepresentable {
	@Environment(\.backgroundMaterial) private var backgroundMaterial

	/// The material shown by the visual effect view.
	private let material: NSVisualEffectView.Material

	/// A value indicating how the view’s contents blend with the surrounding content.
	private let blendingMode: NSVisualEffectView.BlendingMode

	/// A value that indicates whether a view has a visual effect applied.
	private let state: NSVisualEffectView.State

	/// A Boolean value indicating whether to emphasize the look of the material.
	private let isEmphasized: Bool

	/// - Parameters:
	///   - material: The material shown by the visual effect view.
	///   - blendingMode: A value indicating how the view’s contents blend with the surrounding content.
	///   - state: A value that indicates whether a view has a visual effect applied.
	///   - isEmphasized: A Boolean value indicating whether to emphasize the look of the material.
	public nonisolated init(
		material: NSVisualEffectView.Material,
		blendingMode: NSVisualEffectView.BlendingMode,
		state: NSVisualEffectView.State = .followsWindowActiveState,
		isEmphasized: Bool = false
	) {
		self.material = material
		self.blendingMode = blendingMode
		self.state = state
		self.isEmphasized = isEmphasized
	}

	public func makeNSView(context: Context) -> NSVisualEffectView {
		let view = NSVisualEffectView()

		view.material = material
		view.blendingMode = blendingMode
		view.state = state
		view.isEmphasized = isEmphasized

		return view
	}

	public func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
		updating(&nsView.material, with: material)
		updating(&nsView.blendingMode, with: blendingMode)
		updating(&nsView.state, with: state)
		updating(&nsView.isEmphasized, with: isEmphasized)
	}
}
