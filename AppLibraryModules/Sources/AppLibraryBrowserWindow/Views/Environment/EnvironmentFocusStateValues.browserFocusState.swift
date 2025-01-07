import EnvironmentalFocus
import SwiftUI

extension EnvironmentFocusValues {
	var browserFocus: FocusState<BrowserFocusElement?>.Binding {
		get { self[__Key_browserFocus.self] }
		set { self[__Key_browserFocus.self] = newValue }
	}

	private enum __Key_browserFocus: EnvironmentFocusKey {
		typealias Value = BrowserFocusElement?
	}
}

// MARK: - Convenience

extension View {
	nonisolated func browserFocus(_ browserFocus: FocusState<BrowserFocusElement?>.Binding) -> some View {
		environmentFocus(\.browserFocus, browserFocus)
	}
}
