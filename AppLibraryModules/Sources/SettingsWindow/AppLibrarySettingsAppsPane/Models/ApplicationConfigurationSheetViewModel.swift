import AppLibraryRuntimeModel
import SwiftUI

@Observable
final class ApplicationConfigurationSheetViewModel {
	public var selection: ApplicationModel.ID?

	public init() {
		selection = nil
	}
}
