import AppKit
import ApplicationServices
import SwiftyAccessibility

struct DockTile {
	private let accessibilityElement: AXUIElement

	public init?(withTitle title: String) {
		guard
			AccessibilityUtility.isTrusted,
			let accessibilityElement = AXUIElement.dockTile(withTitle: title)
		else {
			return nil
		}
		self.accessibilityElement = accessibilityElement
	}
}

// MARK: - Constants

extension DockTile {
	fileprivate static let dockBundleIdentifier: String = "com.apple.dock"

	public static var main: Self? {
		if let appName = try? Bundle.main.cfBundleName {
			Self(withTitle: appName)
		} else {
			nil
		}
	}
}

// MARK: -

extension DockTile {
	/// The rect for the dock tile.
	public var rect: CGRect? {
		guard let axValues = try? accessibilityElement.values(forAttributes: [.position, .size], options: .stopOnError) else {
			return nil
		}

		var origin = CGPoint.zero
		var size = CGSize.zero

		for axValue in axValues {
			axValue.value(ofType: .cgPoint, &origin)
			axValue.value(ofType: .cgSize, &size)
		}

		return CGRect(origin: origin, size: size)
	}
}

// MARK: -

private extension AXUIElement {
	/// The accessibility element for an app’s dock tile
	static func dockTile(withTitle appTitle: String) -> AXUIElement? {
		if
			let dockElement = AXUIElement.applications(withBundleIdentifier: DockTile.dockBundleIdentifier).last,
			let firstChild = (try? dockElement.children())?.first,
			let children = try? firstChild.children()
		{
			children.first { child in
				(try? child.value(forAttribute: .title)) as? String == appTitle
			}
		} else {
			nil
		}
	}
}
