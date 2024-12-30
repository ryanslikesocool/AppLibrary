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
	func applicationModelIdentifier(_ applicationModelIdentifier: ApplicationModelIdentifier) -> some View {
		environment(\.applicationModelIdentifier, applicationModelIdentifier)
	}

	func applicationModelIdentifier(_ applicationModel: ApplicationModel) -> some View {
		applicationModelIdentifier(ApplicationModelIdentifier(applicationModel))
	}
}
