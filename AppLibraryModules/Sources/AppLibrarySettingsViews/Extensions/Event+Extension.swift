import AppLibraryCommon
import AppLibraryStorage
import Combine

public extension Event {
	static let goToSettingsTab = Passthrough<SettingsCategory>()
}
