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
			ScrollView(.vertical) {
				scrollContent
					.padding(.horizontal, libraryLayout.padding)
			}

			.frame(maxWidth: .infinity)
			.buttonStyle(.plain)

			.safeAreaPadding(.bottom, LibraryLayout.list.padding)
			.safeAreaInset(edge: .top, spacing: LibraryLayout.list.padding) {
				if browserModel.isSearchDisplayed {
					SearchField(focusState: $focusState)
				}
			}

			.onReceive(Event.scrollToApp) { id in
				scrollToApp(id: id, in: proxy)
			}
			.onChange(of: focusState) { _, newValue in
				receiveFocus(newValue: newValue, in: proxy)
			}
		}
	}
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
