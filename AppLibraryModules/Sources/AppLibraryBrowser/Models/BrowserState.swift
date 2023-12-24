import SwiftUI

final class BrowserState: ObservableObject {
	static let shared: BrowserState = BrowserState()

	@Published var searchQuery: String

	private init() {
		searchQuery = ""
	}
}
