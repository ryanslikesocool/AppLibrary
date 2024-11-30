import SwiftUI

protocol AppTileStyle {
	associatedtype Body: View
	typealias Configuration = AppTileStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Self.Configuration) -> Self.Body
}
