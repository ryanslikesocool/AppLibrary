import AppKit
import SwiftUI

public struct VisualEffectView: NSViewRepresentable {
	@Environment(\.backgroundMaterial) private var backgroundMaterial

	private let material: NSVisualEffectView.Material
	private let blendingMode: NSVisualEffectView.BlendingMode
	private let state: NSVisualEffectView.State
	private let isEmphasized: Bool

	/// - Parameters:
	///   - material: The material shown by the visual effect view.
	///   - blendingMode: A value indicating how the view’s contents blend with the surrounding content.
	///   - isEmphasized: A Boolean value indicating whether to emphasize the look of the material.
	public init(
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

	public func updateNSView(_ nsView: NSVisualEffectView, context: Context) { }
}
