import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryResources
import AppLibraryStorage
import SFSymbolToolbox
import SwiftUI

struct SearchField: View {
	@EnvironmentObject private var browserModel: BrowserModel

	@FocusState.Binding private var focusState: BrowserFocusElement?

	private var isFocused: Bool { focusState == Self.focusTarget }

	public init(focusState: FocusState<BrowserFocusElement?>.Binding) {
		_focusState = focusState
	}

	public var body: some View {
		let style: SearchFieldStyle = isFocused ? Self.focusedStyle : Self.unfocusedStyle

		TextField(
			text: $browserModel.searchQuery,
//			prompt: prompt,
			label: makeLabel
		)
//		.keyboardShortcut(.search)
//		.onSubmit(of: .text) {
//			browserModel.filteredApps.first?.open()
//		}

//		.focusable()
		.focused($focusState, equals: Self.focusTarget)

		.searchFieldTextStyle()
		.searchFieldLayout(style: style, containerShape: containerShape)
		.searchFieldDecoration(style: style, isFocused: isFocused)

		.onReceive(Event.activateSearch) { focusState = Self.focusTarget }
		.onExitCommand { focusState = nil }

//		.onAppear { isFocused = browserModel.isSearchFocused }
//		.onChange(of: isFocused) { _, newValue in
//			browserModel.isSearchFocused = newValue
//		}
//		.onChange(of: browserModel.isSearchFocused) { _, newValue in
//			isFocused = newValue
//			if isFocused {
//				browserModel.focusedIndex = nil
//			}
//		}
	}
}

// MARK: - Supporting Views

private extension SearchField {
	func makeLabel() -> some View {
		Label {
			if let title = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) {
				Text(verbatim: title)
			}
		} icon: {
			Image(systemName: .magnifyingGlass)
		}
	}

	var containerShape: some InsettableShape {
		Self.shape
	}

	var prompt: Text? {
		guard let title = try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName) else {
			return nil
		}

		// NOTE: This can't be a `Label` because the
		// `TextField` initializer only supports a `Text` prompt.
		// We also can't use an `Image` interpolation argument for whatever reason...
		return Text(verbatim: "􀊫 \(title)")
	}
}

// MARK: - Constants

private extension SearchField {
	static var unfocusedStyle: SearchFieldStyle {
		SearchFieldStyle(
			shadowA: Shadow(opacity: 0.1, radius: 1, y: 0.5),
			shadowB: Shadow(opacity: 0.05, radius: 2, y: 1),
			stroke: Stroke(position: .inside, shapeStyle: .separator, lineWidth: 1)
		)
	}

	static var focusedStyle: SearchFieldStyle {
		SearchFieldStyle(
			shadowA: Shadow(opacity: 0.25, radius: 4, y: 2),
			shadowB: Shadow(opacity: 0.125, radius: 8, y: 4),
			stroke: Stroke(position: .inside, shapeStyle: Color.accentColor, lineWidth: 2)
		)
	}

	static var backgroundStyle: some ShapeStyle { .regularMaterial }
	static var maskedBlurStyle: some ShapeStyle { .bar }

	static var font: Font { .title3 }
	static var textFieldStyle: some TextFieldStyle { .plain }

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 4
	static let cornerRadius: CGFloat = BrowserWindowShape.cornerRadius - outerPadding

	static let shape: BrowserWindowShape = BrowserWindowShape().inset(by: outerPadding)

	static let isFocusedAnimation: Animation = .easeOut(duration: 0.2)

	static let focusTarget: BrowserFocusElement = .search

	static let fixedSize: (horizontal: Bool, vertical: Bool) = (false, true)
}

// MARK: -

private extension View {
	func searchFieldTextStyle() -> some View {
		font(SearchField.font)
			.textFieldStyle(SearchField.textFieldStyle)
			.autocorrectionDisabled()
	}

	func searchFieldLayout(
		style: SearchFieldStyle,
		containerShape: some InsettableShape
	) -> some View {
		padding(SearchField.innerPadding)
			.overlay(style.stroke, in: containerShape)
//			.overlay(stroke.style, in: containerShape.inset(by: -stroke.width * 0.5).stroke(lineWidth: stroke.width))
			.background(SearchField.backgroundStyle, in: containerShape)
			.fixedSize(horizontal: SearchField.fixedSize.horizontal, vertical: SearchField.fixedSize.vertical)

			.compositingGroup()
			.contentShape(containerShape)
			.padding(SearchField.outerPadding)
	}

	func searchFieldDecoration(
		style: SearchFieldStyle,
		isFocused: Bool
	) -> some View {
		labelStyle(.titleAndIcon)

			.shadow(style.shadowA)
			.shadow(style.shadowB)

			.animation(SearchField.isFocusedAnimation, value: isFocused)

			.background {
//				GeometryReader { geometry in
				MaskedBlur(
					style: SearchField.maskedBlurStyle,
					stepLocation: 0.5
//					stepLocation: 1 - ((SearchField.outerPadding + LibraryLayout.list.padding) / geometry.size.height)
				)
//				}
//				.alignmentGuide(.bottom) { d in
//					d[.bottom] - LibraryLayout.list.padding
//				}
				.padding(.bottom, -LibraryLayout.list.padding)
			}
	}
}
