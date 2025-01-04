import AppLibraryCommon
import SwiftUI

public struct RemoveButton: View {
	private let action: @MainActor () -> Void

	public init(action: @escaping @MainActor () -> Void) {
		self.action = action
	}

	public var body: some View {
		Button(
			String(localized: .common.action.remove),
			systemImage: .trash,
			action: action
		)
	}
}
