import AppLibraryRuntimeModel
import AppLibraryCommonViews
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
	Label == DescriptiveLabel<Text, Text>
{
	static func makeDefaultLabel() -> Label {
		Label(
			title: .applicationVisibilityPicker.title,
			description: .applicationVisibilityPicker.description
		)
	}
}

// MARK: - Convenience

public extension ApplicationVisibilityPicker {
	init(
		for applicationModel: ApplicationModel,
		@ViewBuilder label: () -> Label
	) {
		@Bindable var applicationModel = applicationModel

		self.init(
			selection: $applicationModel.configuration.visibilityFlags,
			label: label
		)
	}
}

public extension ApplicationVisibilityPicker where
	Label == DescriptiveLabel<Text, Text>
{
	init(selection: Binding<SelectionValue>) {
		self.init(selection: selection, label: Self.makeDefaultLabel)
	}

	init(for applicationModel: ApplicationModel) {
		self.init(for: applicationModel, label: Self.makeDefaultLabel)
	}
}
