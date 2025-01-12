import SwiftUI

struct CreditsList<ItemView>: View where
	ItemView: CreditItemView
{
	typealias Item = ItemView.Value

	@EnvironmentObject private var model: AboutWindowModel

	private let valueKeyPath: KeyPath<AboutWindowModel, [Item]>

	private var values: [Item] {
		model[keyPath: valueKeyPath]
	}

	public init(for valueKeyPath: KeyPath<AboutWindowModel, [Item]>) {
		self.valueKeyPath = valueKeyPath
	}

	public var body: some View {
		ForEach(values.indices, id: \.self) { i in
			ItemView(values[i])
		}
		.task {
			await model.loadDefaultCredits(ofType: Item.self)
		}
	}
}
