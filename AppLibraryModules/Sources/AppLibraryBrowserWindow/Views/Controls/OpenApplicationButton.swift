import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public struct OpenApplicationButton: View {
	private let action: @MainActor () -> Void

	private init(action: @escaping @MainActor () -> Void) {
		self.action = action
	}

	public var body: some View {
		Button(action: action) {
			Label(
				String(localized: .common.action.open),
				systemImage: .arrow_up_forward
			)
		}

		// TODO: After updating module to Swift 6, use following implementation.
//		Button(
//			String(localized: .common.action.open),
//			systemImage: .arrow_up_forward
//			action: action
//		)
	}
}

// MARK: - Convenience

public extension OpenApplicationButton {
	init(application applicationModel: ApplicationModel) {
		self.init(action: applicationModel.openLatest)
	}

	init?(application applicationModelIdentifier: ApplicationModelIdentifier) {
		@Application(applicationModelIdentifier) var application
		guard let applicationModel = $application else {
			return nil
		}
		self.init(application: applicationModel)
	}
}
