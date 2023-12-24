import SwiftUI

struct SearchField: View {
	@ObservedObject private var browserState: BrowserState = .shared

	var body: some View {
		Group { }
	}

	private var containerShape: RoundedRectangle {
		RoundedRectangle(cornerRadius: 12)
	}
}

// MARK: - Constants

private extension SearchField {
	static let padding: CGFloat = 4
	static let cornerRadius: CGFloat = BrowserViewController.cornerRadius - padding
}
