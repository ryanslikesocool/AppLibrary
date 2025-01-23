import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension ApplicationIterator {
	struct Grouped: View {
		@FocusState.Binding private var focusState: BrowserFocusElement?

		private let applications: [ApplicationModel]

		public init(
			applications: [ApplicationModel],
			focusState: FocusState<BrowserFocusElement?>.Binding
		) {
			self.applications = applications
			_focusState = focusState
		}

		public var body: some View {
			ForEach(groupedApplications, id: \.subject) { subject, elements in
				Section {
					ApplicationIterator(
						applications: elements,
						focusState: $focusState
					)
				} header: {
					Self.makeSectionHeader(subject: subject)
				}
			}
		}
	}
}

// MARK: - Constants

private extension ApplicationIterator.Grouped {
	static let headerPadding: EdgeInsets = EdgeInsets(vertical: 4)

	static var headerFontWeight: Font.Weight { .medium }
}

// MARK: - Supporting Views

private extension ApplicationIterator.Grouped {
	@ViewBuilder
	static func makeSectionHeader(subject: String) -> some View {
		let text = Text(verbatim: subject)

		switch FeatureFlag.ListView.implementation {
			case .list:
				text
			case .lazyVStack:
				text
					.fontWeight(headerFontWeight)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding(headerPadding)
		}
	}
}

// MARK: - Properties

private extension ApplicationIterator.Grouped {
	var groupedApplications: [(subject: String, elements: [ApplicationModel].SubSequence)] {
		applications
			.chunked(on: Self.createGroupKey(for:))
			.compactMap { key, elements in
				guard let key else {
					return nil
				}
				return (key, elements)
			}
	}
}

// MARK: - Functions

private extension ApplicationIterator.Grouped {
	static func createGroupKey(for element: ApplicationModel) -> String? {
		guard let character = element.displayName.first else {
			return nil
		}

		return if character.isNumber {
			"#"
		} else {
			character.uppercased()
		}
	}
}
