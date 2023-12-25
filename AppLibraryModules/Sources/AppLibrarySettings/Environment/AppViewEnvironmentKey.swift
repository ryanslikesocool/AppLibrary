import SwiftUI

private enum AppViewEnvironmentKey: EnvironmentKey {
	static var defaultValue: AppViewMode = .list
}

public extension EnvironmentValues {
	fileprivate(set) var appView: AppViewMode {
		get { self[AppViewEnvironmentKey.self] }
		set { self[AppViewEnvironmentKey.self] = newValue }
	}
}

public extension View {
	func appView(_ appView: AppViewMode) -> some View {
		environment(\.appView, appView)
	}
}
