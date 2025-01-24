import AppLibraryStorage
import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var applicationVisibilityPickerElements: [ApplicationVisibility]
		= ApplicationVisibility.allCases
}

// MARK: - Convenience

public extension View {
	nonisolated func applicationVisibilityPickerElements(
		_ elements: [ApplicationVisibility]
	) -> some View {
		environment(\.applicationVisibilityPickerElements, elements)
	}
}
