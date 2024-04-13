import SwiftUI

struct SearchField: View {
	@ObservedObject private var browserModel: BrowserModel = .shared
	@FocusState private var isFocused: Bool

	private var shadowA: Shadow { isFocused ? Self.focusedShadowA : Self.unfocusedShadowA }
	private var shadowB: Shadow { isFocused ? Self.focusedShadowB : Self.unfocusedShadowB }

	var body: some View {
		TextField(text: $browserModel.searchQuery, prompt: Text("􀊫 App Library"), label: EmptyView.init)
			.focused($isFocused)

			.font(.title3)
			.textFieldStyle(.plain)

			.padding(Self.innerPadding)
			.background(.separator, in: containerShape.stroke(lineWidth: 1))
			.background(.ultraThinMaterial, in: containerShape)
			.padding(Self.outerPadding)
			.fixedSize(horizontal: false, vertical: true)
			.compositingGroup()

			.shadow(color: .black.opacity(shadowA.opacity), radius: shadowA.radius, y: shadowA.y)
			.shadow(color: .black.opacity(shadowB.opacity), radius: shadowB.radius, y: shadowB.y)

			.animation(.easeOut(duration: 0.2), value: isFocused)

			.onAppear { isFocused = browserModel.isSearchFocused }
			.onChange(of: isFocused) { browserModel.isSearchFocused = isFocused }
			.onChange(of: browserModel.isSearchFocused) { isFocused = browserModel.isSearchFocused }
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 12)
	}
}

// MARK: - Constants

private extension SearchField {
	typealias Shadow = (opacity: Double, radius: Double, y: Double)

	static let unfocusedShadowA: Shadow = (0.1, 1, 0.5)
	static let unfocusedShadowB: Shadow = (0.05, 2, 1)

	static let focusedShadowA: Shadow = (0.2, 2, 1)
	static let focusedShadowB: Shadow = (0.1, 4, 2)

	static let innerPadding: CGFloat = 8
	static let outerPadding: CGFloat = 8
	static let cornerRadius: CGFloat = BrowserViewController.cornerRadius - outerPadding
}
