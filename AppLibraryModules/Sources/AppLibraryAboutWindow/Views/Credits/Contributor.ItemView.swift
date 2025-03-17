import AppLibraryResources
import SFSymbolToolbox
import SwiftUI

extension Contributor {
	struct ItemView: CreditItemView {
		public typealias Value = Contributor

		private let value: Value

		public nonisolated init(_ value: Value) {
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
			String(localized: .credits.link.personal.title),
			systemImage: .link,
			destination: value.personalURL
		)
	}

	var githubLink: some View {
		// TODO: add github icon
		Link(
			String(localized: .credits.link.gitHub.title),
			icon: EmptyView(),
			destination: value.githubURL
		)
	}
}
