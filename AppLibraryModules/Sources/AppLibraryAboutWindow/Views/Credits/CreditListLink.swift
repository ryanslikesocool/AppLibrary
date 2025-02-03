import AcknowledgementToolbox
import SwiftUI

struct CreditListLink<Value>: View where
	Value: CreditItem
{
	private let title: String

	public init(
		ofType valueType: Value.Type
	) {
		title = String(localized: Value.creditKind.localizedStringResource)
	}

	public var body: some View {
		NavigationLink {
			AcknowledgementList(content: Value.ItemView.init(_:))
				.labeledContentStyle(.simpleAcknowledgement)
				.navigationTitle(title)
				.frame(minHeight: 300)
		} label: {
			Label(
				title,
				systemImage: Value.creditKind.systemImageName
			)
		}
	}
}
