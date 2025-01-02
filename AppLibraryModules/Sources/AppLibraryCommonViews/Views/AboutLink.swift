import AppLibraryResources
import SwiftUI

public struct AboutLink<Label>: View where
	Label: View
{
	@Environment(\.openAbout) private var openAbout

	private let label: () -> Label

	public init(@ViewBuilder label: @escaping () -> Label) {
		self.label = label
	}

	public var body: some View {
		Button(action: onButtonAction, label: label)
	}
}

// MARK: - Functions

private extension AboutLink {
	func onButtonAction() {
		openAbout()
	}
}

// MARK: - Convenience

public extension AboutLink where
	Label == Text
{
	init<S>(_ title: S) where
		S: StringProtocol
	{
		self.init(label: { Text(title) })
	}

	init(_ title: LocalizedStringResource) {
		self.init(label: { Text(title) })
	}

	init(_ titleKey: LocalizedStringKey) {
		self.init(label: { Text(titleKey) })
	}
}

public extension AboutLink where
	Label == SwiftUI.Label<Text, Image>
{
	init<S>(_ title: S, systemImage name: String) where
		S: StringProtocol
	{
		self.init(label: { Label(title, systemImage: name) })
	}

	init(_ title: LocalizedStringResource, systemImage name: String) {
		self.init(label: { Label(title, systemImage: name) })
	}

	init(_ titleKey: LocalizedStringKey, systemImage name: String) {
		self.init(label: { Label(titleKey, systemImage: name) })
	}

	init() {
		self.init {
			Label(String(localized: .aboutWindow.title), image: "info")
		}
	}
}
