import AppLibraryCommon
import AppLibraryStorage
import Combine

public extension Event {
	@MainActor static let goToSettingsTab = Passthrough<SettingsCategory>()
}
