import SwiftUI

public protocol ApplicationLabelStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = ApplicationLabelStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
