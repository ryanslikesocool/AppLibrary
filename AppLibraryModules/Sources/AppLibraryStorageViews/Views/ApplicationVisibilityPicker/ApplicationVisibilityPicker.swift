import AppLibraryStorage
import SwiftUI

public struct ApplicationVisibilityPicker<Label>: View where
	Label: View
{
	public typealias Configuration = ApplicationVisibilityPickerStyleConfiguration
	public typealias SelectionValue = ApplicationVisibility.Set

	@Environment(\.applicationVisibilityPickerStyle) private var style
	@Environment(\.applicationVisibilityPickerElements) private var elements

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
			elements: elements,
			label: label
		)

		style.makeBody(configuration: configuration)
	}
}

// MARK: - Constants

private extension ApplicationVisibilityPicker where
	Label == Text
{
	nonisolated static var defaultLabel: Label {
		Text(.applicationVisibilityPicker.label)
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
		@Storage(apps: \.applicationVisibilityFlags) var applicationVisibilityFlags
		self.init(
			selection: Binding(
				get: { applicationVisibilityFlags[applicationModelIdentifier, default: .visible] },
				set: { newValue in applicationVisibilityFlags[applicationModelIdentifier] = newValue }
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
