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
					DevelopedWithLoveLink()
				}
			}
			.scenePadding()
		}
		.frame(width: Self.width)
		.fixedSize(horizontal: true, vertical: true)
	}
}

// MARK: - Constants

private extension ContentView {
	static let spacing: CGFloat? = 24
	static let width: CGFloat? = 256
}
