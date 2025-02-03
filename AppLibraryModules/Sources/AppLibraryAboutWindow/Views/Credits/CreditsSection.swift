import AcknowledgementToolbox
import SwiftUI

struct CreditsSection: View {
	public init() { }

	public var body: some View {
		VStack {
			CreditListLink(ofType: Contributor.self)
			CreditListLink(ofType: Acknowledgement.self)
		}
		.buttonStyle(.expandingLabel(.horizontal))
		.controlSize(.large)
	}
}
