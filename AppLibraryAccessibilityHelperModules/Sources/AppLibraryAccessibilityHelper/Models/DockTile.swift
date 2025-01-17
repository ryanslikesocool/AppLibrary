import ApplicationServices
import AXToolbox

public struct DockTile {
	private let accessibilityElement: AXUIElement

	init(accessibilityElement: AXUIElement) {
		self.accessibilityElement = accessibilityElement
	}
}

// MARK: - Constants

public extension DockTile {
	// NOTE: `Bundle.main` will return the extension bundle.
//	// TODO: Should `main` be retained somewhere so we don't keep recalculating it?
//	// Or is it safer to recalculate it?
//	static func main(in dock: Dock? = Dock.main) -> Self? {
//		dock?.applicationTile(withURL: Bundle.main.bundleURL)
//	}
}

// MARK: -

public extension DockTile {
	/// The rect for the dock tile.
	var rect: CGRect? {
		try? accessibilityElement.value(forAttribute: .frame)
	}

	/// The position of the dock tile on the screen.
	///
	/// - Remark: If this property is used in the same scope as ``size``,
	/// consider using the `origin` and `size` properties on ``rect`` instead.
	var position: CGPoint? {
		try? accessibilityElement.value(forAttribute: .position)
	}

	/// The size of the dock tile.
	///
	/// - Remark: If this property is used in the same scope as ``position``,
	/// consider using the `origin` and `size` properties on ``rect`` instead.
	var size: CGSize? {
		try? accessibilityElement.value(forAttribute: .size)
	}
}
