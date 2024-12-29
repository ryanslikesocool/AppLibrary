import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public struct HideApplicationButton: View {
	private let applicationModelIdentifier: ApplicationModelIdentifier

	private init(application applicationModelIdentifier: ApplicationModelIdentifier) {
		self.applicationModelIdentifier = applicationModelIdentifier
	}

	public var body: some View {
		Button(action: buttonAction) {
			Label(.common.action.hide, systemImage: .eye_slash)
		}
	}
}

// MARK: - Functions

private extension HideApplicationButton {
	func buttonAction() {
		AppsSettings.shared.hideApplication(with: applicationModelIdentifier)
	}
}

// MARK: - Convenience

public extension HideApplicationButton {
	init(application applicationModel: borrowing ApplicationModel) {
		self.init(application: ApplicationModelIdentifier(applicationModel))
	}
}
