import AppLibraryStorage
import SwiftUI

struct SearchField: View {
	@ObservedObject private var appSettings: AppSettings = .shared
	@ObservedObject private var browserModel: BrowserModel = .shared
	@FocusState private var isFocused: Bool

	private var shadowA: Shadow { isFocused ? Self.focusedShadowA : Self.unfocusedShadowA }
	private var shadowB: Shadow { isFocused ? Self.focusedShadowB : Self.unfocusedShadowB }
	private var stroke: Stroke { /* isFocused ? Self.focusedStroke : Self.unfocusedStroke */ Self.unfocusedStroke }

	var body: some View {
		TextField(text: $browserModel.searchQuery, prompt: Text("􀊫 App Library"), label: EmptyView.init)

			.focusable()
			.focused($isFocused)
//			.focusEffectDisabled()

			.font(.title3)
			.textFieldStyle(.plain)

			.padding(Self.innerPadding)
			.overlay(stroke.style, in: containerShape.inset(by: -stroke.width * 0.5).stroke(lineWidth: stroke.width))
			.background(appSettings.display.searchBackgroundMaterial, in: containerShape)
			.fixedSize(horizontal: false, vertical: true)
			.compositingGroup()
			.contentShape(containerShape)
			.padding(Self.outerPadding)

			.shadow(color: .black.opacity(shadowA.opacity), radius: shadowA.radius, y: shadowA.y)
			.shadow(color: .black.opacity(shadowB.opacity), radius: shadowB.radius, y: shadowB.y)

			.animation(.easeOut(duration: 0.2), value: isFocused)

			.onAppear { isFocused = browserModel.isSearchFocused }
			.onChange(of: isFocused) { _, newValue in
				browserModel.isSearchFocused = newValue
			}
			.onChange(of: browserModel.isSearchFocused) { _, newValue in
				isFocused = newValue
				if isFocused {
					browserModel.focusedIndex = nil
				}
			}
	}
}

// MARK: - Supporting Views

private extension SearchField {
	var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 12)
	}
}

// MARK: - Constants

private extension SearchField {
	static let unfocusedShadowA: Shadow = (0.1, 1, 0.5)
	static let unfocusedShadowB: Shadow = (0.05, 2, 1)

	static let focusedShadowA: Shadow = (0.25, 4, 2)
	static let focusedShadowB: Shadow = (0.125, 8, 4)

	static let unfocusedStroke: Stroke = (AnyShapeStyle(.separator), 1)
	static let focusedStroke: Stroke = (AnyShapeStyle(Color.accentColor), 2)

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 8
	static let cornerRadius: CGFloat = BrowserViewController.cornerRadius - outerPadding
}
