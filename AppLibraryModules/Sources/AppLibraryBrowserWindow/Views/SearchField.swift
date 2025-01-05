import AppLibraryCommon
import AppLibraryCommonViews
import AppLibraryResources
import AppLibraryStorage
import SFSymbolToolbox
import SwiftUI

struct SearchField: View {
	@EnvironmentObject private var browserModel: BrowserModel
	@FocusState private var isFocused: Bool

	private var shadowA: Shadow { isFocused ? Self.focusedShadowA : Self.unfocusedShadowA }
	private var shadowB: Shadow { isFocused ? Self.focusedShadowB : Self.unfocusedShadowB }
	private var stroke: Stroke { /* isFocused ? Self.focusedStroke : Self.unfocusedStroke */ Self.unfocusedStroke }

	public init() { }

	public var body: some View {
		TextField(
			text: $browserModel.searchQuery,
			prompt: prompt,
			label: EmptyView.init
		)
//		.keyboardShortcut(.search)
//		.onSubmit(of: .text) {
//			browserModel.filteredApps.first?.open()
//		}

		.focusable()
		.focused($isFocused)

		.font(Self.font)
		.textFieldStyle(Self.textFieldStyle)
		.autocorrectionDisabled()

		.padding(Self.innerPadding)
		.overlay(stroke, in: containerShape)
//		.overlay(stroke.style, in: containerShape.inset(by: -stroke.width * 0.5).stroke(lineWidth: stroke.width))
		.background(Self.backgroundStyle, in: containerShape)
		.fixedSize(horizontal: false, vertical: true)
		.compositingGroup()
		.contentShape(containerShape)
		.padding(Self.outerPadding)

		.shadow(shadowA)
		.shadow(shadowB)

		.animation(Self.isFocusedAnimation, value: isFocused)

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
	var containerShape: some InsettableShape {
		Self.shape
	}

	var prompt: Text {
		let title = try! Bundle.main.object(forInfoDictionaryKey: .cfBundleName)

		// NOTE: This can't be a `Label` because the
		// `TextField` initializer only supports a `Text` prompt.
		// We also can't use an `Image` interpolation argument for whatever reason...
		return Text(verbatim: "􀊫 \(title)")
	}
}

// MARK: - Constants

private extension SearchField {
	static let unfocusedShadowA: Shadow = Shadow(opacity: 0.1, radius: 1, y: 0.5)
	static let unfocusedShadowB: Shadow = Shadow(opacity: 0.05, radius: 2, y: 1)

	static let focusedShadowA: Shadow = Shadow(opacity: 0.25, radius: 4, y: 2)
	static let focusedShadowB: Shadow = Shadow(opacity: 0.125, radius: 8, y: 4)

	static var unfocusedStroke: Stroke { Stroke(position: .inside, shapeStyle: .separator, lineWidth: 1) }
	static var focusedStroke: Stroke { Stroke(position: .inside, shapeStyle: Color.accentColor, lineWidth: 2) }

	static var backgroundStyle: some ShapeStyle { .regularMaterial }

	static var font: Font { .title3 }
	static var textFieldStyle: some TextFieldStyle { .plain }

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 4
	static let cornerRadius: CGFloat = BrowserWindowShape.cornerRadius - outerPadding

	static let shape: BrowserWindowShape = BrowserWindowShape().inset(by: outerPadding)

	static let isFocusedAnimation: Animation = .easeOut(duration: 0.2)
}
