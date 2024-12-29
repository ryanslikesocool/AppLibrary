import SwiftUI

public struct URLLabel: View {
	private let url: URL

	public init(_ url: URL) {
		self.url = url
	}

	public var body: some View {
		Text(verbatim: url.abbreviatingWithTildeInPath)
	}
}
