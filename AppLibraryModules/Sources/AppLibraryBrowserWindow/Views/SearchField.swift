import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

struct SearchField: View {
	@EnvironmentObject private var browserModel: BrowserModel

	@FocusState.Binding private var focusState: BrowserFocusElement?

	public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
		_focusState = focusState
	}

	public var body: some View {
		HStack(alignment: .firstTextBaseline, spacing: Self.labelSpacing) {
			makeLabelIcon()
				.foregroundStyle(Self.labelIconStyle)

			TextField(
				text: $browserModel.searchQuery,
				label: makeLabelTitle
			)
			.focused($focusState, equals: Self.focusTarget)
		}

		.searchFieldTextStyle()
		.searchFieldLayout(containerShape: containerShape)
		.searchFieldBackground()
		.searchFieldEvents(browserModel: browserModel, focusState: $focusState)
	}
}

// MARK: - Supporting Views

private extension SearchField {
	@ViewBuilder
	func makeLabelTitle() -> some View {
		if let title = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) {
			Text(verbatim: title)
		}
	}

	func makeLabelIcon() -> some View {
		Image(systemName: .magnifyingGlass)
	}

	var containerShape: some InsettableShape {
		Self.shape
	}
}

// MARK: - Constants

private extension SearchField {
	static var backgroundStyle: some ShapeStyle { .bar }
	static var maskedBlurStyle: some ShapeStyle { .ultraThickMaterial }

	static let labelSpacing: CGFloat = 4
	static let labelVerticalAlignment: VerticalAlignment = .firstTextBaseline
	static var labelFont: Font { .title3 }
	static var labelTextFieldStyle: some TextFieldStyle { .plain }
	static var labelIconStyle: some ShapeStyle { .tertiary }

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 4
	static let cornerRadius: CGFloat = BrowserWindowShape.cornerRadius - outerPadding

	static let shape: BrowserWindowShape = BrowserWindowShape().inset(by: outerPadding)

	static let focusTarget: BrowserFocusElement = .search

	static let fixedSize: (horizontal: Bool, vertical: Bool) = (false, true)
}

// MARK: -

private extension View {
	func searchFieldTextStyle() -> some View {
		font(SearchField.labelFont)
			.textFieldStyle(SearchField.labelTextFieldStyle)
			.autocorrectionDisabled()
			.writingToolsDisabled()
	}

	func searchFieldLayout(
		containerShape: some InsettableShape
	) -> some View {
		padding(SearchField.innerPadding)
			.background(SearchField.backgroundStyle, in: containerShape)
			.fixedSize(horizontal: SearchField.fixedSize.horizontal, vertical: SearchField.fixedSize.vertical)

			.compositingGroup()
			.contentShape(containerShape)
			.padding(SearchField.outerPadding)
	}

	func searchFieldBackground() -> some View {
		background {
//			GeometryReader { geometry in
			MaskedBlur(
				style: SearchField.maskedBlurStyle,
				stepLocation: 0.5
//				stepLocation: 1 - ((SearchField.outerPadding + LibraryLayout.list.padding) / geometry.size.height)
			)
//			}
//			.alignmentGuide(.bottom) { d in
//				d[.bottom] - LibraryLayout.list.padding
//			}
			.padding(.bottom, -LibraryLayout.list.padding)
		}
	}

	func searchFieldEvents(
		browserModel: BrowserModel,
		focusState: FocusState<BrowserFocusElement?>.Binding
	) -> some View {
		return onReceive(Event.activateSearch) {
			FeatureFlag.Input.logEvent(in: SearchField.self, named: "activate")
			focusState.wrappedValue = SearchField.focusTarget
		}
		.onMoveCommand { direction in
			FeatureFlag.Input.logEvent(in: SearchField.self, named: "move")
			browserModel.onMoveSearch(direction: direction)
		}
		.onExitCommand {
			FeatureFlag.Input.logEvent(in: SearchField.self, named: "exit")
			focusState.wrappedValue = nil
		}
		.onSubmit {
			FeatureFlag.Input.logEvent(in: SearchField.self, named: "submit")
			browserModel.onSubmitSearch()
		}
	}
}
