import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

extension Acknowledgement {
	struct ItemView: AppLibraryAboutWindow.CreditItemView {
		private let value: Value

		public init(_ value: Acknowledgement) {
			self.value = value
		}

		public var body: some View {
			LabeledContent {
				projectLink
				licenseLink
			} label: {
				Text(verbatim: value.name)
			}
		}
	}
}

// MARK: - Supporting Views

private extension Acknowledgement.ItemView {
	var projectLink: some View {
		Link(
			String(localized: .credits.link.project),
			systemImage: .link,
			destination: value.projectURL
		)
	}

	var licenseLink: some View {
		// TODO: replace with scales symbol if/when one becomes available
		Link(
			String(localized: .credits.link.license),
			systemImage: .building_columns,
			destination: value.licenseURL
		)
	}
}
