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
			HStack {
				label

				Spacer()

				projectLink
				licenseLink
			}
			.labelStyle(.iconOnly)
		}
	}
}

// MARK: - Supporting Views

private extension Acknowledgement.ItemView {
	var label: some View {
		Text(verbatim: value.name)
			.fontWeight(.bold)
	}

	var projectLink: some View {
		Link(
			String(localized: .acknowledgements.link.project),
			systemImage: .link,
			destination: value.projectURL
		)
	}

	var licenseLink: some View {
		// TODO: replace with scales symbol if/when one becomes available
		Link(
			String(localized: .acknowledgements.link.license),
			systemImage: .building_columns,
			destination: value.licenseURL
		)
	}
}
