import AppLibraryCommon
import SwiftUI

public struct RemoveButton: View {
	private let action: () -> Void

	public init(action: @escaping () -> Void) {
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Label("Remove", systemImage: Constant.Symbol.trash)
		}
	}
}
