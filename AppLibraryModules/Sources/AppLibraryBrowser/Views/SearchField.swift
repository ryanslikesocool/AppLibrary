import AppLibraryStorage
import SwiftUI

struct SearchField: View {
	@EnvironmentObject private var browserModel: BrowserModel
	@FocusState private var isFocused: Bool

	private var shadowA: Shadow { isFocused ? Self.focusedShadowA : Self.unfocusedShadowA }
	private var shadowB: Shadow { isFocused ? Self.focusedShadowB : Self.unfocusedShadowB }
	private var stroke: Stroke { /* isFocused ? Self.focusedStroke : Self.unfocusedStroke */ Self.unfocusedStroke }

	public init() { }

	public var body: some View {
		TextField(text: $browserModel.searchQuery, prompt: Text("􀊫 App Library"), label: EmptyView.init)
//			.onSubmit(of: .text) {
//				browserModel.filteredApps.first?.open()
//			}

			.focusable()
			.focused($isFocused)

			.font(.title3)
			.textFieldStyle(.plain)

			.padding(Self.innerPadding)
			.overlay(stroke.style, in: containerShape.inset(by: -stroke.width * 0.5).stroke(lineWidth: stroke.width))
			.background(.regularMaterial, in: containerShape)
			.fixedSize(horizontal: false, vertical: true)
			.compositingGroup()
			.contentShape(containerShape)
			.padding(Self.outerPadding)

			.shadow(color: .black.opacity(shadowA.opacity), radius: shadowA.radius, y: shadowA.y)
			.shadow(color: .black.opacity(shadowB.opacity), radius: shadowB.radius, y: shadowB.y)

			.animation(.easeOut(duration: 0.2), value: isFocused)

//			.onAppear { isFocused = browserModel.isSearchFocused }
//			.onChange(of: isFocused) { _, newValue in
//				browserModel.isSearchFocused = newValue
//			}
//			.onChange(of: browserModel.isSearchFocused) { _, newValue in
//				isFocused = newValue
//				if isFocused {
//					browserModel.focusedIndex = nil
//				}
//			}
	}
}

// MARK: - Supporting Views

private extension SearchField {
	var containerShape: some InsettableShape {
		Self.shape
	}
}

// MARK: - Constants

private extension SearchField {
	static let unfocusedShadowA: Shadow = Shadow(opacity: 0.1, radius: 1, y: 0.5)
	static let unfocusedShadowB: Shadow = Shadow(opacity: 0.05, radius: 2, y: 1)

	static let focusedShadowA: Shadow = Shadow(opacity: 0.25, radius: 4, y: 2)
	static let focusedShadowB: Shadow = Shadow(opacity: 0.125, radius: 8, y: 4)

	static let unfocusedStroke: Stroke = Stroke(style: .separator, width: 1)
	static let focusedStroke: Stroke = Stroke(style: Color.accentColor, width: 2)

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 4
	static let cornerRadius: CGFloat = BrowserWindowShape.cornerRadius - outerPadding

	static let shape: BrowserWindowShape = BrowserWindowShape().inset(by: outerPadding)
}
