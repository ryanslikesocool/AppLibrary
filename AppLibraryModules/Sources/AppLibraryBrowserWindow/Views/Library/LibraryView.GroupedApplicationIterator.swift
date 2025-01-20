import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct GroupedApplicationIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel

		@FocusState.Binding private var focusState: BrowserFocusElement?

		public init(
			focusState: FocusState<BrowserFocusElement?>.Binding
		) {
			_focusState = focusState
		}

		public var body: some View {
			ForEach(groupedApplications, id: \.subject) { subject, elements in
				Section {
					ForEach(elements, id: \.bundleIdentifier) { application in
						ApplicationTile(for: application)
							.focused($focusState, equals: .application(application))
					}
				} header: {
					Self.makeSectionHeader(subject: subject)
				}
			}
		}
	}
}

// MARK: - Constants

private extension LibraryView.GroupedApplicationIterator {
	static let headerPadding: EdgeInsets = EdgeInsets(vertical: 4)
	static var headerFont: Font { .subheadline.weight(.semibold) }
}

// MARK: - Supporting Views

private extension LibraryView.GroupedApplicationIterator {
	static func makeSectionHeader(subject: String) -> some View {
		Text(verbatim: subject)
			.font(headerFont)
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(headerPadding)
	}
}

// MARK: - Properties

private extension LibraryView.GroupedApplicationIterator {
	var groupedApplications: [(subject: String, elements: [ApplicationModel].SubSequence)] {
		browserModel.filteredApps
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

private extension LibraryView.GroupedApplicationIterator {
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
