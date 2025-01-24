import AppLibraryCommon
import AppLibraryStorage
import SwiftUI

public struct ApplicationVisibilityPickerStyleConfiguration {
	public typealias SelectionValue = ApplicationVisibility.Set

	@Binding public var selection: SelectionValue
	public let elements: [SelectionValue.Enum]
	public let label: Label

	@MainActor
	init(
		selection: Binding<SelectionValue>,
		elements: [SelectionValue.Enum],
		label: some View
	) {
		_selection = selection
		self.elements = elements
		self.label = Label(label)
	}
}

// MARK: - Supporting Data

public extension ApplicationVisibilityPickerStyleConfiguration {
	/// The type erased label of an ``ApplicationVisibilityPicker``.
	struct Label: View {
		fileprivate init(_ content: some View) {
			body = AnyView(content)
		}

		public let body: AnyView
	}
}
