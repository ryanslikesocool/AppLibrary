import SwiftUI

public protocol SectionStyle: Sendable {
	associatedtype Body: View
	typealias Configuration = SectionStyleConfiguration

	@ViewBuilder
	@MainActor
	func makeBody(configuration: Configuration) -> Self.Body
}
