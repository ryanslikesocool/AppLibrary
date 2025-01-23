import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

struct LibraryView: View {
	@Environment(\.libraryLayout) private var libraryLayout
	@EnvironmentObject private var browserModel: BrowserModel
	@FocusState.Binding private var focusState: BrowserFocusElement?

	public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
		_focusState = focusState
	}

	public var body: some View {
		ScrollViewReader { proxy in
			// NOTE: `List` displays the ideal header and separator style,
			// but I can't figure out how to make the header material uniform with the search background.

			ScrollView(.vertical) {
				scrollContent
			}

			.buttonStyle(.plain)

			.contentMargins([.horizontal, .bottom], libraryLayout.padding, for: .scrollContent)
			.safeAreaInset(edge: .top, spacing: Self.searchSpacing) {
				if browserModel.isSearchDisplayed {
					SearchField(focusState: $focusState)
				}
			}

			.onReceive(Event.scrollToApp) { id in
				scrollToApp(id: id, in: proxy)
			}
//			.onChange(of: focusState) { _, newValue in
//				receiveFocus(newValue: newValue, in: proxy)
//			}
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
		if browserModel.searchQuery.isEmpty {
			switch libraryLayout {
				case .list: ListView(focusState: $focusState)
				case .grid: GridView(focusState: $focusState)
			}
		} else {
			ListView(focusState: $focusState)
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
