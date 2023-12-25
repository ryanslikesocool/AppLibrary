import AppKit

extension Application {
	func getURL() -> URL? {
		NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleIdentifier)
	}

	func getBundle() -> Bundle? {
		guard let url = getURL() else {
			return nil
		}
		return Bundle(url: url)
	}

	func getBundle(url: URL) -> Bundle? {
		Bundle(url: url)
	}

	func getIcon() -> NSImage {
		guard let url = getURL() else {
			return Self.genericIcon
		}

		if let bundle = getBundle(url: url) {
			if
				let iconName = bundle.infoDictionary?["CFBundleIconName"] as? String,
				let image = bundle.image(forResource: iconName)
			{
				return image
			}

			if
				let iconFile = bundle.infoDictionary?["CFBundleIconFile"] as? String,
				let image = bundle.image(forResource: iconFile)
			{
				return image
			}

			if
				let bundleIcons = bundle.infoDictionary?["CFBundleIcons"] as? [String: Any],
				let primaryIcon = bundleIcons["CFBundlePrimaryIcon"] as? [String: Any]
			{
				if
					let iconName = primaryIcon["CFBundleIconName"] as? String,
					let image = bundle.image(forResource: iconName)
				{
					return image
				}

				if
					let files = primaryIcon["CFBundleIconFiles"] as? [String],
					let file = files.first,
					let image = bundle.image(forResource: file)
				{
					return image
				}
			}
		}

		return Self.genericIcon // NSWorkspace.shared.icon(forFile: url.path())
	}
}

// MARK: - Constants

private extension Application {
	static let genericIcon: NSImage = NSImage(named: "GenericAppIcon")!
}
