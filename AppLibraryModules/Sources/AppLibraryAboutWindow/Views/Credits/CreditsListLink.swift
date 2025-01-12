import AppLibraryCommonViews
import AppLibraryResources
import SwiftUI

struct CreditsListLink: View {
	private let text: Text

	/// - Parameters:
	///   - text:
	public init(_ text: Text) {
		self.text = text
	}

	public var body: some View {
		Button(action: buttonAction) {
			text
		}
		.buttonStyle(Self.buttonStyle)
		.controlSize(Self.controlSize)
		.disabled(true)
	}
}

// MARK: - Constants

private extension CreditsListLink {
	static var buttonStyle: some PrimitiveButtonStyle { .automatic.expandingLabel(.horizontal) }
	static let controlSize: ControlSize = .large
}

// MARK: - Functions

private extension CreditsListLink {
	func buttonAction() {
		fatalError("\(Self.self).\(#function) is not implemented")
	}
}

// MARK: - Convenience

extension CreditsListLink {
	/// - Parameters:
	///   - title:
	init<S>(
		_ title: S
	) where
		S: StringProtocol
	{
		self.init(Text(title))
	}

	/// - Parameters:
	///   - titleResource:
	@_disfavoredOverload
	init(
		_ titleResource: LocalizedStringResource
	) {
		self.init(Text(titleResource))
	}

	/// - Parameters:
	///   - titleKey:
	init(
		_ titleKey: LocalizedStringKey
	) {
		self.init(Text(titleKey))
	}
}
