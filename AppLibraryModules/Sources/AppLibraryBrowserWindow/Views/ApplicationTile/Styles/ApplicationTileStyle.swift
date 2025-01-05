import SwiftUI

protocol ApplicationTileStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = ApplicationTileStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Self.Configuration) -> Self.Body
}
