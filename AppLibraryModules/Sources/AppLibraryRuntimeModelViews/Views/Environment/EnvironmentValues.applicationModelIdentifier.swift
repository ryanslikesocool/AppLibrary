import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var applicationModelIdentifier: ApplicationModelIdentifier
		= ApplicationModelIdentifier(Bundle.main.bundleIdentifier!)
}

// MARK: - Convenience

public extension View {
	nonisolated func applicationModelIdentifier(
		_ applicationModelIdentifier: ApplicationModelIdentifier
	) -> some View {
		environment(\.applicationModelIdentifier, applicationModelIdentifier)
	}

	nonisolated func applicationModelIdentifier(
		_ applicationModel: ApplicationModel
	) -> some View {
		applicationModelIdentifier(ApplicationModelIdentifier(applicationModel))
	}
}
