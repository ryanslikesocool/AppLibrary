import AppLibraryCommonViews
import AppLibraryResources
import SwiftUI

struct ContentView: View {
	public init() { }

	public var body: some View {
		NavigationStack {
			VStack(spacing: Self.spacing) {
				Divided {
					AppInfoSection()
					CreditsSection()
					CopyrightSection()
				}
			}
			.scenePadding()
		}
		.frame(width: Self.width)
		.fixedSize(horizontal: true, vertical: true)
		.toolbar {
			// NOTE: This view is included to force the window to create a toolbar
			// at the top level of the `NavigationStack`.
			Spacer()
		}
	}
}

// MARK: - Constants

private extension ContentView {
	static let spacing: CGFloat? = 24
	static let width: CGFloat? = 256
}
