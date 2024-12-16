import LocalizationTable
import SwiftUI

struct SheetFormItem<SheetContent>: View where
	SheetContent: View
{
	@State private var isSheetPresented: Bool = false

	private let table: LocalizationTableResource
	private let sheetContent: () -> SheetContent

	public init(table: LocalizationTableResource, @ViewBuilder sheetContent: @escaping () -> SheetContent) {
		self.table = table
		self.sheetContent = sheetContent
	}

	public var body: some View {
		LabeledContent(content: makeButton) {
			Text("TITLE", table: table)
			Text("FORM.DESCRIPTION", table: table)
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
			Text("ACTION.MANAGE.EXTERNAL", table: .common)
		}
	}
}
