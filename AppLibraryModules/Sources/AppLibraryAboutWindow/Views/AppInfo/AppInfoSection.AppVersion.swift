import AppLibraryCommon
import AppLibraryResources
import OSLog
import SFSymbolToolbox
import SwiftUI

extension AppInfoSection {
	struct AppVersion: View {
		@State private var isHovering: Bool = false

		public init() { }

		public var body: some View {
			if let appVersion = try? Bundle.main.object(forInfoDictionaryKey: .applicationVersion()) {
				Button {
					buttonAction(appVersion)
				} label: {
					Text(verbatim: appVersion)
						.overlay(alignment: .trailing) {
							if isHovering {
								hoverIcon
							}
						}
						.font(Self.font)
						.foregroundStyle(Self.foregroundStyle)
				}
				.buttonStyle(Self.buttonStyle)
				.onHover { newValue in
					withAnimation {
						isHovering = newValue
					}
				}
			}
		}
	}
}

// MARK: - Constants

private extension AppInfoSection.AppVersion {
	static var font: Font { .body.monospaced() }
	static var foregroundStyle: some ShapeStyle { .secondary }

	static var overlaySystemImageName: SystemSymbolName { .document_on_clipboard }
	static var overlayImageTransition: some Transition { .opacity.animation(overlayImageAnimation) }
	static var overlayImageAnimation: Animation { .interactiveSpring }
	nonisolated static let overlayImageSpacing: CGFloat = 64

	static var buttonStyle: some PrimitiveButtonStyle { .plain }
}

// MARK: - Supporting Views

private extension AppInfoSection.AppVersion {
	var hoverIcon: some View {
		Image(systemName: Self.overlaySystemImageName)
			// TODO: Figure out how to replace `.padding` with `.alignmentGuide`
//			.alignmentGuide(.leading) { dimension in
//				dimension[.trailing] + Self.overlayImageSpacing
//			}
			.padding(.trailing, -Self.overlayImageSpacing)
			.transition(Self.overlayImageTransition)
	}
}

// MARK: - Functions

private extension AppInfoSection.AppVersion {
	func buttonAction(_ appVersion: String) {
		let appName = NSApplication.shared.appName
		let copyString = "\(appName) \(appVersion)"

		let pasteboard = NSPasteboard.general
		pasteboard.clearContents()
		pasteboard.setString(copyString, forType: .string)

		Logger.module.debug("Copied application version.")
	}
}
