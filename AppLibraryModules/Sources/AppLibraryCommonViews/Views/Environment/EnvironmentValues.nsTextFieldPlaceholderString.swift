import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var nsTextFieldPlaceholderString: String? = nil
}

// MARK: - Convenience

public extension View {
	/// - Parameter placeholderString: The value to apply to
	/// [`placeholderString`]( https://developer.apple.com/documentation/appkit/nstextfield/placeholderstring )
	/// on any `NSTextField`s in the environment.
	nonisolated func nsTextFieldPlaceholderString(_ placeholderString: String?) -> some View {
		environment(\.nsTextFieldPlaceholderString, placeholderString)
	}
}
