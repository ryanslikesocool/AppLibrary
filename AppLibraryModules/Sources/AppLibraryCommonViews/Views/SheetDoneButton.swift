import SwiftUI

public struct SheetDoneButton: View {
	@Environment(\.dismiss) private var dismiss

	public init() { }

	public var body: some View {
		Button(String(localized: .common.action.done)) {
			dismiss()
		}
		.buttonStyle(.borderedProminent)
	}
}
