import AppLibraryAccessibilityHelperCommon
import ApplicationServices
import AXToolbox
import OSLog

public struct Dock {
	public let listElement: AXUIElement

	private init?() {
		guard
			let rootElement = AXUIElement.applications(withBundleIdentifier: Self.bundleIdentifier).last,
			let listElement = (try? rootElement.children())?.first
		else {
			return nil
		}

#if DEBUG
		Self.logElement(rootElement, label: "Accessibility Element - Root", attributes: [
			.role,
		])

//		Self.logElement(rootElement, label: "Accessibility Element - Root") { element in
//			"""
//			- Role: \(String(describing: try? element.value(forAttribute: .role)))
//			"""
//		}

		Self.logElement(listElement, label: "Accessibility Element - List", attributes: [
			.role,
			.children,
			.frame,
			.orientation,
		])

//		Self.logElement(listElement, label: "Accessibility Element - List") { element in
//			"""
//			- Role: \(String(describing: try? element.value(forAttribute: .role)))
//			- Children: \(String(describing: try? element.value(forAttribute: .children)))
//			- Frame: \(String(describing: try? element.value(forAttribute: .frame)))
//			- Orientation: \(String(describing: try? element.value(forAttribute: .orientation)))
//			"""
//		}
#endif

		assert((try? rootElement.value(forAttribute: .role)) == .application)
		assert((try? listElement.value(forAttribute: .role)) == .list)

		self.listElement = listElement
	}
}

// MARK: - Constants

extension Dock {
	static let logger = Logger(category: Self.self)

	static let bundleIdentifier: String = "com.apple.dock"

	// TODO: Should `main` be retained somewhere so we don't keep recalculating it?
	// Or is it safer to recalculate it?
	public static var main: Self? {
		Self()
	}
}

// MARK: - Logging

private extension Dock {
#if DEBUG
	static func logElement(
		_ element: AXUIElement?,
		label: StaticString,
		attributes attributeKeys: [any AXAttributeKey]
	) {
		guard FeatureFlag.Dock.logAccessibilityElements else {
			return
		}

		logElement(element, label: label) { element in
			attributeKeys
				.map { attributeKey in
					"- \(type(of: attributeKey)): \(String(describing: try? element.value(forAttribute: attributeKey)))"
				}
				.joined(separator: "\n")
		}
	}

	static func logElement(
		_ element: AXUIElement?,
		label: StaticString,
		description: ((AXUIElement) -> String)? = nil
	) {
		guard FeatureFlag.Dock.logAccessibilityElements else {
			return
		}

		let messagePrefix: String = """
		\(label):
		- Element: \(String(describing: element))
		"""

		if
			let element,
			let description
		{
			Self.logger.debug("""
			\(messagePrefix)
			\(description(element))
			""")
		} else {
			Self.logger.debug("\(messagePrefix)")
		}
	}
#endif
}

// MARK: - Application Tiles

public extension Dock {
	/// Retrieve the first dock tile with an accessibility element that matches the given `predicate`.
	/// - Parameter predicate: The predicate to match.
	/// - Returns: The first dock tile with an accessibility element that matches the given `predicate` if one could be found; `nil` otherwise.
	func applicationTile(where predicate: (AXUIElement) throws -> Bool) rethrows -> DockTile? {
		guard
			let children = try? listElement.value(forAttribute: .children),
			let matchingElement = try children.first(where: predicate)
		else {
			return nil
		}

		assert((try? matchingElement.value(forAttribute: .role)) == .dockItem)
		assert((try? matchingElement.value(forAttribute: .subrole)) == .applicationDockItem)

#if DEBUG
		Self.logElement(matchingElement, label: "Accessibility Element - Dock Tile", attributes: [
			.role,
			.subrole,
			.frame,
			.url,
		])

//		Self.logElement(matchingElement, label: "Accessibility Element - Dock Tile") { element in
//			"""
//			- Role: \(String(describing: try? element.value(forAttribute: .role)))
//			- Subrole: \(String(describing: try? element.value(forAttribute: .subrole)))
//			- Frame: \(String(describing: try? element.value(forAttribute: .frame)))
//			- URL: \(String(describing: try? element.value(forAttribute: .url)))
//			"""
//		}
#endif

		return DockTile(accessibilityElement: matchingElement)
	}

	/// Retrieve the first dock tile with an accessibility element that has the given `url`.
	/// - Parameter url: The URL to look for.
	/// - Returns: The first dock tile with an accessibility element that has the given `url` if one could be found; `nil` otherwise.
	func applicationTile(withURL url: URL) -> DockTile? {
		applicationTile { element in
			(try? element.value(forAttribute: .url)) == url
		}
	}
}
