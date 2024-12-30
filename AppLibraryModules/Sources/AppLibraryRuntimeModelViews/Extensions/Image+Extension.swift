import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public extension Image {
	init(applicationIcon applicationModelIdentifier: ApplicationModelIdentifier) {
		@Application(applicationModelIdentifier) var application
		self.init(applicationIcon: $application)
	}

	init(applicationIcon applicationModel: ApplicationModel) {
		self.init(nsImage: applicationModel.getLatestIcon())
	}

	init(applicationIcon applicationModel: ApplicationModel?) {
		self.init(nsImage: applicationModel.getLatestIcon())
	}
}
