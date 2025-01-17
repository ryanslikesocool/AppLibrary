import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public extension ShowInFinderButton where
	Label == SwiftUI.Label<Text, Image>
{
	init(latestInstance applicationModel: ApplicationModel) {
		self.init(applicationModel.latestInstance?.url)
	}

	init(latestInstance applicationModelIdentifier: ApplicationModelIdentifier) {
		@Application(applicationModelIdentifier) var application
		self.init($application?.latestInstance?.url)
	}
}
