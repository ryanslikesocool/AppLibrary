import SwiftUI

protocol AppTileStyle {
	associatedtype Body: View
	typealias Configuration = AppTileStyleConfiguration

	@ViewBuilder func makeBody(configuration: Self.Configuration) -> Self.Body
}
