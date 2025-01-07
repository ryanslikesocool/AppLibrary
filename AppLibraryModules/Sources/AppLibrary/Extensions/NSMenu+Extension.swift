import AppKit

extension NSMenu {
	func item(withTitle titleKey: LocalizedStringResource) -> NSMenuItem? {
		item(withTitle: String(localized: titleKey))
	}
}
