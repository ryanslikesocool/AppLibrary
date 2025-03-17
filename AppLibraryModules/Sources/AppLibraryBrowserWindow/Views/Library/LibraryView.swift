import AppLibraryCommon
import AppLibraryRuntimeModel
import SwiftData
import AppLibraryStorage
import SwiftUI

struct LibraryView: View {
	@Environment(\.libraryLayout) private var libraryLayout
	@EnvironmentObject private var browserModel: BrowserModel
	@Query private var applications: [ApplicationModel]
	@FocusState.Binding private var focusState: BrowserFocusElement?

	public init(
		focusState: FocusState<BrowserFocusElement?>.Binding
	) {
		// NOTE: Ideally, we'd perform filtering in the query, but Swift Predicates are a pain...
		let sortDescriptors: [SortDescriptor<ApplicationModel>] = [
			SortDescriptor(\.displayName),
		]
		_applications = Query(sort: sortDescriptors)

		_focusState = focusState
	}

	public var body: some View {
		ScrollViewReader { proxy in
			Group {
				switch FeatureFlag.ListView.implementation {
					case .list:
						// NOTE: `List` displays the ideal header and separator style,
						// but I can't figure out how to make the header material uniform with the search background.
						// TODO: look into NSCollectionView https://developer.apple.com/documentation/appkit/nscollectionview
						List {
							scrollContent
						}
						.scrollContentBackground(.hidden)
					case .lazyVStack:
						ScrollView(.vertical) {
							scrollContent
						}
				}
			}
			.buttonStyle(.plain)

			.onReceive(Event.scrollToApp) { id in
				scrollToApp(id: id, in: proxy)
			}
//			.onKeyPress(characters: .alphanumerics) { (keyPress: KeyPress) -> KeyPress.Result in
//				// TODO: jump to first application where name starts with `keyPress.characters`
//			}
			.onChange(of: focusState) { _, newValue in
				receiveFocus(newValue: newValue, in: proxy)
			}
		}
		.contentMargins([.horizontal, .bottom], libraryLayout.padding, for: .scrollContent)
		.safeAreaInset(edge: .top, spacing: Self.searchSpacing) {
			if browserModel.isSearchDisplayed {
				SearchField(focusState: $focusState)
			}
		}
	}
}

// MARK: - Constants

private extension LibraryView {
	static let searchSpacing: CGFloat? = 0
}

// MARK: - Supporting Views

private extension LibraryView {
	@ViewBuilder
	var scrollContent: some View {
		if browserModel.search.isEmpty {
			switch libraryLayout {
				case .list: ListView(applications: filteredApplications, focusState: $focusState)
				case .grid: GridView(applications: filteredApplications, focusState: $focusState)
			}
		} else {
			ListView(applications: filteredApplications, focusState: $focusState)
		}
	}
}

// MARK: - Event Receivers

private extension LibraryView {
	func receiveFocus(newValue: BrowserFocusElement?, in proxy: ScrollViewProxy) {
		switch newValue {
			case let .application(application)?: scrollToApp(id: application, in: proxy)
			default: break
		}
	}

	func scrollToApp(id: ApplicationModelIdentifier, in proxy: ScrollViewProxy) {
		proxy.scrollTo(id, anchor: .top)
	}

	func scrollToSection(character: Character, in proxy: ScrollViewProxy) {
		proxy.scrollTo(character, anchor: .top)
	}
}

// MARK: - Properties

private extension LibraryView {
	var filteredApplications: [ApplicationModel] {
		applications.filter(using: browserModel.search)
	}
}
