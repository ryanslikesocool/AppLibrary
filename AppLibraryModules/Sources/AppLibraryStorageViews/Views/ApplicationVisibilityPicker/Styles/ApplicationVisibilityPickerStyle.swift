import SwiftUI

public protocol ApplicationVisibilityPickerStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = ApplicationVisibilityPickerStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
