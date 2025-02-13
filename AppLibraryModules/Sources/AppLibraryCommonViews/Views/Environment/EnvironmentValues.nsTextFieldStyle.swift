import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var nsTextFieldStyle: NSTextFieldStyle = NSTextFieldStyle()
}

// MARK: - Convenience

public extension View {
	/// - Parameter style: The style to apply to any `NSTextField`s in the environment.
	nonisolated func nsTextFieldStyle(
		_ style: NSTextFieldStyle
	) -> some View {
		environment(\.nsTextFieldStyle, style)
	}
}
