import AppLibraryCommon
import LocalizationTable
import SwiftUI

struct SheetFormItem<SheetContent>: View where
	SheetContent: View
{
	@State private var isSheetPresented: Bool = false

	private let titleKey: LocalizedStringKey
	private let descriptionKey: LocalizedStringKey
	private let table: LocalizationTableResource
	private let sheetContent: () -> SheetContent

	public init(
		title titleKey: LocalizedStringKey,
		description descriptionKey: LocalizedStringKey,
		table: LocalizationTableResource,
		@ViewBuilder sheetContent: @escaping () -> SheetContent
	) {
		self.titleKey = titleKey
		self.descriptionKey = descriptionKey
		self.table = table
		self.sheetContent = sheetContent
	}

	public var body: some View {
		LabeledContent(content: makeButton) {
			Text(titleKey, table: table)
			Text(descriptionKey, table: table)
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
			Text(.common.link.manage, table: .common)
		}
	}
}
