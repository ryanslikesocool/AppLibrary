import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

extension Contributor {
	struct ItemView: AppLibraryAboutWindow.CreditItemView {
		private let value: Value

		public init(_ value: Contributor) {
			self.value = value
		}

		public var body: some View {
			LabeledContent {
				personalLink
				githubLink
			} label: {
				Text(verbatim: value.name)
			}
		}
	}
}

// MARK: - Supporting Views

private extension Contributor.ItemView {
	var personalLink: some View {
		Link(
			String(localized: .credits.link.personal),
			systemImage: .link,
			destination: value.personalURL
		)
	}

	var githubLink: some View {
		// TODO: add github icon
		Link(
			String(localized: .credits.link.github),
			icon: EmptyView(),
			destination: value.githubURL
		)
	}
}
