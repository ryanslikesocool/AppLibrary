import SwiftUI
import BundleToolbox

struct CopyrightSection: View {
	public init() { }

	public var body: some View {
		VStack(spacing: Self.spacing) {
			ApplicationCopyrightLabel()
			DevelopedWithLoveLink()
		}
	}
}

// MARK: - Constants

private extension CopyrightSection {
	static let spacing: CGFloat? = 12
}