import AppLibraryStorage
import SwiftUI

struct AppearancePicker: View {
	public typealias SelectionValue = Appearance?

	@Storage(general: \.appearance) private var selection: SelectionValue

	public init() { }

	public var body: some View {
		Picker("Appearance", selection: $selection) {
			makeItem(.none) {
				Text("Automatic")
			}

			Section {
				makeItem(.light) {
					Text("Light")
				}

				makeItem(.dark) {
					Text("Dark")
				}
			}
		}
		.onChange(of: selection, selection.apply)
	}
}

// MARK: - Supporting Views

private extension AppearancePicker {
	func makeItem(
		_ tag: SelectionValue,
		@ViewBuilder label: () -> some View
	) -> some View {
		label()
			.tag(tag)
	}
}
