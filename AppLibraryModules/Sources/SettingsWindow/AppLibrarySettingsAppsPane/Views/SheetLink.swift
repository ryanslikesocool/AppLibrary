import AppLibraryCommon
import SwiftUI

struct SheetLink<Label, SheetContent>: View where
	Label: View,
	SheetContent: View
{
	@State private var isSheetPresented: Bool = false

	private let sheetContent: () -> SheetContent
	private let label: Label

	/// - Parameters:
	///   - sheetContent:
	///   - label:
	public init(
		@ViewBuilder sheetContent: @escaping () -> SheetContent,
		@ViewBuilder label: () -> Label
	) {
		self.sheetContent = sheetContent
		self.label = label()
	}

	public var body: some View {
		LabeledContent(content: makeButton) {
			label
		}
		.sheet(isPresented: $isSheetPresented, content: sheetContent)
	}
}

// MARK: - Supporting Views

private extension SheetLink {
	func makeButton() -> some View {
		Button {
			isSheetPresented = true
		} label: {
			Text(
				LocalizedStringResource.common.link.format(.common.action.manage)
			)
		}
	}
}

// MARK: - Convenience

extension SheetLink {
	/// - Parameters:
	///   - title:
	///   - description:
	///   - sheetContent:
	init(
		_ title: some StringProtocol,
		description: some StringProtocol,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) where
		Label == TupleView<(Text, Text)>
	{
		self.init(sheetContent: sheetContent) {
			Text(title)
			Text(description)
		}
	}

	/// - Parameters:
	///   - titleResource:
	///   - descriptionResource:
	///   - sheetContent:
	init(
		_ titleResource: LocalizedStringResource,
		description descriptionResource: LocalizedStringResource,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) where
		Label == TupleView<(Text, Text)>
	{
		self.init(sheetContent: sheetContent) {
			Text(titleResource)
			Text(descriptionResource)
		}
	}

	/// - Parameters:
	///   - title:
	///   - sheetContent:
	init(
		_ title: some StringProtocol,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) where
		Label == Text
	{
		self.init(sheetContent: sheetContent) {
			Text(title)
		}
	}

	/// - Parameters:
	///   - titleResource:
	///   - sheetContent:
	init(
		_ titleResource: LocalizedStringResource,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) where
		Label == Text
	{
		self.init(sheetContent: sheetContent) {
			Text(titleResource)
		}
	}
}
