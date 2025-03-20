import AppLibraryRuntimeModel
import SwiftUI

@Observable
final class ApplicationConfigurationEditorViewModel {
	public var selection: ApplicationModel.ID?

	public init() {
		selection = nil
	}
}
