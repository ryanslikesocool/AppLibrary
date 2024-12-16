import AppLibraryCommon
import LocalizationTable
import SwiftUI

struct SheetFormItem<SheetContent>: View where
	SheetContent: View
{
	@State private var isSheetPresented: Bool = false

	private let title: LocalizedStringResource
	private let description: LocalizedStringResource
	private let sheetContent: () -> SheetContent

	public init(
		title: LocalizedStringResource,
		description: LocalizedStringResource,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) {
		self.title = title
		self.description = description
		self.sheetContent = sheetContent
	}

	public var body: some View {
		LabeledContent(content: makeButton) {
			Text(title)
			Text(description)
		}
		.sheet(isPresented: $isSheetPresented, content: sheetContent)
	}
}

// MARK: - Supporting Views

private extension SheetFormItem {
	func makeButton() -> some View {
		Button {
			isSheetPresented = true
		} label: {
			Text(.common.link.manage)
		}
	}
}
