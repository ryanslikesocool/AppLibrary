import AppKit

public extension NSMenuItem {
	func withSubmenuItems(
		_ items: some Collection<NSMenuItem>
	) -> Self {
		let submenu = self.submenu ?? NSMenu(title: title)
		submenu.items.append(contentsOf: items)
		self.submenu = submenu
		return self
	}
}