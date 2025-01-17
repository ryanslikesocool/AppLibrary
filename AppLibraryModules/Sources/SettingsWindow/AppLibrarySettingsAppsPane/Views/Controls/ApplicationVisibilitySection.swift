import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

struct ApplicationVisibilitySection: View {
	@Binding private var selection: ApplicationVisibility.Set

	private init(
		selection: Binding<ApplicationVisibility.Set>
	) {
		_selection = selection
	}

	public var body: some View {
		Section {
			ForEach(Self.elementOrder) { element in
				Toggle(
					selection: $selection,
					element: element
				)
			}
		} header: {
			Text(.applicationVisibilityPicker.label)
			Text(.applicationVisibilityPicker.description)
		}
	}
}

// MARK: - Constants

private extension ApplicationVisibilitySection {
	static let elementOrder: [ApplicationVisibility] = ApplicationVisibility.allCases
}

// MARK: - Convenience

extension ApplicationVisibilitySection {
	init(
		for applicationModelIdentifier: ApplicationModelIdentifier
	) {
		@Storage(apps: \.applicationVisibilityFlags) var applicationVisibilityFlags
		self.init(
			selection: Binding(
				get: { applicationVisibilityFlags[applicationModelIdentifier, default: .visible] },
				set: { newValue in applicationVisibilityFlags[applicationModelIdentifier] = newValue }
			)
		)
	}
}