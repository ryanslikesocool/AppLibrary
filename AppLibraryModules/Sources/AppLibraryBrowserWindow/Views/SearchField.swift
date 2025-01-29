import AppLibraryCommon
import AppLibraryCommonViews
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
		Group {
			switch FeatureFlag.Search.viewImplementation {
				case .appKit:
					NSSearchFieldRepresentable(string: $browserModel.searchQuery)
						.nsTextFieldPlaceholderString(NSApplication.shared.appName)
				case .swiftUI:
					HStack(alignment: .firstTextBaseline, spacing: Self.labelSpacing) {
						labelIcon
							.foregroundStyle(Self.labelIconStyle)

						TextField(text: $browserModel.searchQuery) {
							labelTitle
						}
					}

					.searchFieldTextStyle()
					.searchFieldLayout()
			}
		}
		.padding(SearchField.outerPadding)
		.controlSize(.large)

		.focusEffectDisabled()
		.focused($focusState, equals: .search)

		.searchFieldBackground()

		.inputCommandRepublisher()
	}
}

// MARK: - Supporting Views

private extension SearchField {
	var labelTitle: some View {
		Text(verbatim: NSApplication.shared.appName)
	}

	var labelIcon: some View {
		Image(systemName: .magnifyingGlass)
	}
}

// MARK: - Constants

private extension SearchField {
	static var backgroundStyle: some ShapeStyle { .regularMaterial }
	static var maskedBlurStyle: some ShapeStyle {
//		Color.red
//		.ultraThickMaterial
		.thickMaterial
//		.bar
	}

	static var strokeStyle: some ShapeStyle { .separator }

	static let labelSpacing: CGFloat = 4
	static let labelVerticalAlignment: VerticalAlignment = .firstTextBaseline
	static var labelFont: Font { .title3 }
	static var labelTextFieldStyle: some TextFieldStyle { .plain }
	static var labelIconStyle: some ShapeStyle { .tertiary }

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 5

	static let containerShape: some InsettableShape = BrowserWindowShape().inset(by: outerPadding)

	static let fixedSize: (horizontal: Bool, vertical: Bool) = (false, true)
}

// MARK: -

private extension View {
	func searchFieldTextStyle() -> some View {
		font(SearchField.labelFont)
			.textFieldStyle(SearchField.labelTextFieldStyle)
			.autocorrectionDisabled()
	}

	func searchFieldLayout() -> some View {
		padding(SearchField.innerPadding)
			.overlay(SearchField.strokeStyle, in: SearchField.containerShape.stroke(lineWidth: 1))
			.background(SearchField.backgroundStyle, in: SearchField.containerShape)
			.fixedSize(horizontal: SearchField.fixedSize.horizontal, vertical: SearchField.fixedSize.vertical)

			.compositingGroup()
			.contentShape(SearchField.containerShape)
	}

	@ViewBuilder
	func searchFieldBackground() -> some View {
		switch FeatureFlag.ListView.implementation {
			case .list:
				// NOTE: Besides `NSVisualEffectView.Material.headerView`, `Material.Bar` is the closest match to the section header material.
				// However, SwiftUI treats the search field background and section header background as different views, so the material looks incorrect :(
				background(.bar)
			case .lazyVStack:
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
					.padding(.bottom, -LibraryLayout.list.padding * 1.5)
				}
		}
	}
}
