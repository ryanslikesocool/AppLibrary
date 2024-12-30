import AppLibraryRuntimeModel
import SwiftUI

public extension EnvironmentValues {
	var applicationModel: ApplicationModel? {
		@Application(applicationModelIdentifier) var application
		return $application
	}
}
