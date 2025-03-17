import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

extension Acknowledgement {
	struct ItemView: CreditItemView {
		public typealias Value = Acknowledgement

		private let value: Value

		public nonisolated init(_ value: Value) {
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
			String(localized: .credits.link.project.title),
			systemImage: .link,
			destination: value.projectURL
		)
	}

	var licenseLink: some View {
		// TODO: replace with scales symbol if/when one becomes available
		Link(
			String(localized: .credits.link.license.title),
			systemImage: .building_columns,
			destination: value.licenseURL
		)
	}
}
