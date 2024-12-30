import AppLibraryCommon
import SwiftUI

public extension EnvironmentValues {
	@MainActor
	var openAbout: EnvironmentAction {
		EnvironmentAction {
			openWindow(id: WindowIdentifier.about)
		}
	}
}