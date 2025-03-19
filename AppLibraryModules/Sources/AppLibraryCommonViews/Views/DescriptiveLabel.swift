import SwiftUI

public struct DescriptiveLabel<Title, Description>: View where
	Title: View,
	Description: View
{
	@Environment(\.descriptiveLabelElementVisibility) private var elementVisibility

	private let title: () -> Title
	private let description: () -> Description

	public init(
		@ViewBuilder title: @escaping () -> Title,
		@ViewBuilder description: @escaping () -> Description
	) {
		self.title = title
		self.description = description
	}

	public var body: some View {
		if elementVisibility.contains(.title) {
			title()
		}

		if elementVisibility.contains(.description) {
			description()
		}
	}
}

// MARK: - Convenience

public extension DescriptiveLabel where
	Title == Text,
	Description == Text
{
	init(
		title titleResource: @autoclosure @escaping () -> LocalizedStringResource,
		description descriptionResource: @autoclosure @escaping () -> LocalizedStringResource
	) {
		self.init {
			Title(titleResource())
		} description: {
			Description(descriptionResource())
		}
	}
}