import SwiftUI

public struct BrowserWindowLink<Label>: View where
	Label: View
{
	@Environment(\.openWindow) private var openWindow

	private let label: Label

	/// - Parameters:
	///   - label:
	public init(
		@ViewBuilder label: () -> Label
	) {
		self.label = label()
	}

	public var body: some View {
		Button(action: buttonAction) {
			label
		}
	}
}

// MARK: - Functions

private extension BrowserWindowLink {
	func buttonAction() {
		openWindow(id: .browser)
	}
}

// MARK: - Convenience

public extension BrowserWindowLink where
	Label == Text
{
	/// - Parameters:
	///   - title:
	init<S>(
		_ title: S
	) where
		S: StringProtocol
	{
		self.init {
			Text(title)
		}
	}

	/// - Parameters:
	///   - titleKey:
	init(
		_ titleKey: LocalizedStringKey
	) {
		self.init {
			Text(titleKey)
		}
	}

	init() {
		self.init(LocalizedStringResource.browserWindow.title)
	}
}
