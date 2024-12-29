import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public struct OpenApplicationButton: View {
	private let action: () -> Void

	private init(action: @escaping () -> Void) {
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Label(.common.action.open, systemImage: .arrow_up_forward)
		}
	}
}

// MARK: - Convenience

public extension OpenApplicationButton {
	init(application applicationModel: ApplicationModel) {
		self.init(action: applicationModel.openLatest)
	}

	init?(application applicationModelIdentifier: ApplicationModelIdentifier) {
		guard let applicationModel = ApplicationCache.shared.applications[applicationModelIdentifier] else {
			return nil
		}
		self.init(application: applicationModel)
	}
}
