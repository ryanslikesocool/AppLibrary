import SwiftUI

public protocol ErrorViewStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = ErrorViewStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
