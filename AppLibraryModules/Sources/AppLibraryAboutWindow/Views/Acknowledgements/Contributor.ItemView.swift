import AppLibraryResources
import SwiftUI

extension Contributor {
	struct ItemView: AppLibraryAboutWindow.AcknowledgementItemView {
		private let value: Value

		public init(_ value: Contributor) {
			self.value = value
		}

		public var body: some View {
			HStack {
				label

				Spacer()

				personalLink
				githubLink
			}
			.labelStyle(.iconOnly)
		}
	}
}

// MARK: - Supporting Views

private extension Contributor.ItemView {
	var label: some View {
		Text(verbatim: value.name)
			.fontWeight(.bold)
	}

	var personalLink: some View {
		Link(
			String(localized: .acknowledgements.link.personal),
			systemImage: "link",
			destination: value.personalURL
		)
	}

	var githubLink: some View {
		// TODO: add github icon
		Link(
			String(localized: .acknowledgements.link.github),
			icon: EmptyView(),
			destination: value.githubURL
		)
	}
}
