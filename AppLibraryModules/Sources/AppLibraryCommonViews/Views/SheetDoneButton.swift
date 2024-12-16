import SwiftUI

public struct SheetDoneButton: View {
	@Environment(\.dismiss) private var dismiss

	public init() { }

	public var body: some View {
		Button {
			dismiss()
		} label: {
			Text(.common.action.done, table: .common)
		}
		.buttonStyle(.borderedProminent)
	}
}
