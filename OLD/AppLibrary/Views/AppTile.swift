import ALSettings
import AppKit
import LoveCore
import MoreViews
import SwiftUI

struct AppTile: View {
	@EnvironmentObject private var appDelegate: AppDelegate
	@Environment(\.libraryStyle) private var libraryStyle: LibraryStyle

	@Binding private var app: AppIdentifier

	init(_ app: Binding<AppIdentifier>) {
		_app = app
	}

	var body: some View {
		button
			.contextMenu {
				Button("Open", action: buttonAction)
				Button("Show in Finder") {
					NSWorkspace.shared.activateFileViewerSelecting([app.url])
				}
				Divider()
				Button("Hide") { app.isHidden = true }
					.keyboardShortcut("h")
			}
	}
}

// MARK: - Data

private extension AppTile {
	var sourceImage: NSImage? {
		loadRepresentation(for: Self.retrieveIcon(for: app.url))
			?? loadRepresentation(for: NSWorkspace.shared.icon(forFile: app.url.path()))
			?? genericAppIcon
	}
}

// MARK: - Views

private extension AppTile {
	var button: some View {
		Group {
			switch libraryStyle {
				case .tile: tileButton
				case .list: listButton
			}
		}
	}

	private var tileButton: some View {
		Button(action: buttonAction) {
			iconContent
		}
		.buttonStyle(.scale(pressedScale: 0.95))
		.overlay(alignment: .bottom) {
			text
				.font(.footnote)
//				.frame(maxWidth: iconWidth + appDelegate.settings.spacing * 0.5)
				.fixedSize()
				.multilineTextAlignment(.center)
				.help(app.description)
				.offset(y: 16)
		}
	}

	private var listButton: some View {
		Button(action: buttonAction) {
			HStack {
				iconContent
				text
				Spacer()
			}
			.padding(horizontal: 8, vertical: 4)
			.contentShape(Rectangle())
		}
		.buttonStyle(.plain)
	}

	private var text: some View {
		Text(app.description)
	}

	private var iconContent: some View {
		Group {
			if let sourceImage {
				Image(nsImage: sourceImage)
			} else {
				RoundedRectangle(cornerRadius: 12, style: .continuous)
					.redacted(reason: .placeholder)
			}
		}
		.frame(width: iconWidth, height: iconHeight)
	}

	private func buttonAction() {
		Self.openApplication(at: app.url)
	}
}

// MARK: - Icon

extension AppTile {
	var iconWidth: Double {
		switch libraryStyle {
			case .tile: return 48 // appDelegate.settings.iconSize
			case .list: return 48
		}
	}

	var iconHeight: Double { iconWidth }
	var iconSize: CGSize { CGSize(width: iconWidth, height: iconHeight) }

	var genericAppIcon: NSImage? {
		loadRepresentation(for: NSImage(named: "GenericAppIcon"))
	}

	func loadRepresentation(for image: NSImage?) -> NSImage? {
		NSImage.loadRepresentation(for: image, size: iconSize)
	}

	private static func retrieveIcon(for url: URL) -> NSImage? {
		guard
			let bundle = Bundle(url: url),
			let plist = bundle.infoDictionary,
			let iconFile = plist["CFBundleIconFile"] as? String
		else {
			return nil
		}
		return bundle.image(forResource: iconFile)
	}

	private static let openApplicationConfiguration: NSWorkspace.OpenConfiguration = {
		let result: NSWorkspace.OpenConfiguration = NSWorkspace.OpenConfiguration()
		// config if needed
		return result
	}()

	static func openApplication(at url: URL) {
		NSWorkspace.shared.openApplication(at: url, configuration: openApplicationConfiguration)
	}
}