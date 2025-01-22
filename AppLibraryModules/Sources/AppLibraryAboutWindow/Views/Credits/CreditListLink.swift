import AcknowledgementToolbox
import SwiftUI

struct CreditListLink<Value>: View where
	Value: CreditItem
{
	public init(
		ofType valueType: Value.Type
	) { }

	public var body: some View {
		NavigationLink {
			AcknowledgementList(content: Value.ItemView.init(_:))
				.navigationTitle(
					String(localized: Value.creditKind.localizedStringResource)
				)
		} label: {
			Text(Value.creditKind.localizedStringResource)
//				.frame(maxWidth: .infinity)
		}
	}
}
