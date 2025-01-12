import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

extension LibraryView {
	struct GroupedApplicationIterator: View {
		@EnvironmentObject private var browserModel: BrowserModel

		@FocusState.Binding private var focusState: BrowserFocusElement?

		private var groupedApplications: [(subject: String, elements: [ApplicationModel].SubSequence)] {
			browserModel.filteredApps.chunked(on: Self.createGroupKey(for:))
				.compactMap { key, elements in
					guard let key else {
						return nil
					}
					return (key, elements)
				}
		}

		private static func createGroupKey(for element: ApplicationModel) -> String? {
			guard let character = element.displayName.first else {
				return nil
			}
			return if character.isNumber {
				"#"
			} else {
				character.uppercased()
			}
		}

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
					makeSectionHeader(subject)
				}
			}
			.focusSection()
		}
	}
}

// MARK: - Constants

private extension LibraryView.GroupedApplicationIterator {
	static var headerMaxWidth: CGFloat? { .infinity }
	static let headerAlignment: Alignment = .leading
}

// MARK: - Supporting Views

private extension LibraryView.GroupedApplicationIterator {
	func makeSectionHeader(_ subject: String) -> some View {
		Text(verbatim: subject)
			.frame(maxWidth: Self.headerMaxWidth, alignment: Self.headerAlignment)
	}
}
