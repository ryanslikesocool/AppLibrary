import SwiftUI

struct SearchField: View {
	@FocusState private var focused: Bool
	@Binding var searchQuery: String

	private var shadowA: Shadow { focused ? Self.focusedShadowA : Self.unfocusedShadowA }
	private var shadowB: Shadow { focused ? Self.focusedShadowB : Self.unfocusedShadowB }

	var body: some View {
		TextField(text: $searchQuery, prompt: Text("􀊫 App Library"), label: EmptyView.init)
			.focused($focused)
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

			.animation(.easeOut(duration: 0.2), value: focused)

			.onAppear {
				DispatchQueue.main.async(execute: loseFocus)
			}
			.onSubmit(loseFocus)
			.onExitCommand(perform: loseFocus)

			.background {
				Button("Search App Library", action: { focused = true })
					.keyboardShortcut("f")
					.opacity(0.01)
			}
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 12)
	}

	private func loseFocus() {
		focused = false
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
