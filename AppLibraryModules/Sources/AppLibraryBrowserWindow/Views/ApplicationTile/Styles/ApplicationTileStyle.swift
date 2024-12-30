import SwiftUI

protocol ApplicationTileStyle {
	associatedtype Body: View
	typealias Configuration = ApplicationTileStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Self.Configuration) -> Self.Body
}
