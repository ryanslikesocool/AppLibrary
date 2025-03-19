import AppLibraryStorage
import SwiftUI

public struct ApplicationVisibilityPicker<Label>: View where
	Label: View
{
	public typealias Configuration = ApplicationVisibilityPickerStyleConfiguration
	public typealias SelectionValue = ApplicationVisibility.Set

	@Environment(\.applicationVisibilityPickerStyle) private var style

	@Binding private var selection: SelectionValue

	private let label: Label

	public init(
		selection: Binding<SelectionValue>,
		@ViewBuilder label: () -> Label
	) {
		_selection = selection
		self.label = label()
	}

	public var body: some View {
		let configuration = Configuration(
			selection: $selection,
			items: Self.items,
			label: label
		)

		style.makeBody(configuration: configuration)
	}
}

// MARK: - Constants

private extension ApplicationVisibilityPicker {
	static var items: [SelectionValue.Enum] {
		SelectionValue.Enum.allCases
	}
}

private extension ApplicationVisibilityPicker where
	Label == Text
{
	nonisolated static var defaultLabel: Label {
		Text(.applicationVisibilityPicker.title)
	}
}

private extension ApplicationVisibilityPicker where
	Label == TupleView<(Text, Text)>
{
	@ViewBuilder
	nonisolated static var defaultLabel: Label {
		ApplicationVisibilityPicker<Text>.defaultLabel
		Text(.applicationVisibilityPicker.description)
	}
}

// MARK: - Convenience

public extension ApplicationVisibilityPicker {
	init(
		for applicationModelIdentifier: ApplicationModelIdentifier,
		@ViewBuilder label: () -> Label
	) {
		@Storage(apps: \.applicationConfiguration) var applicationConfiguration
		self.init(
			selection: Binding(
				get: { applicationConfiguration[applicationModelIdentifier, default: ApplicationConfiguration()].visibilityFlags },
				set: { newValue in
					applicationConfiguration[applicationModelIdentifier, default: ApplicationConfiguration()]
						.visibilityFlags = newValue
				}
			),
			label: label
		)
	}
}

public extension ApplicationVisibilityPicker where
	Label == Text
{
	init(selection: Binding<SelectionValue>) {
		self.init(selection: selection, label: { Self.defaultLabel })
	}

	init(for applicationModelIdentifier: ApplicationModelIdentifier) {
		self.init(for: applicationModelIdentifier, label: { Self.defaultLabel })
	}
}

public extension ApplicationVisibilityPicker where
	Label == TupleView<(Text, Text)>
{
	init(selection: Binding<SelectionValue>) {
		self.init(selection: selection, label: { Self.defaultLabel })
	}

	init(for applicationModelIdentifier: ApplicationModelIdentifier) {
		self.init(for: applicationModelIdentifier, label: { Self.defaultLabel })
	}
}
