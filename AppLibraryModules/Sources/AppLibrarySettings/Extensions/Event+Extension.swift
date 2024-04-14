import AppLibraryCommon
import Combine

public extension Event {
	static let goToSettingsTab = PassthroughSubject<SettingsTab, Never>()
}
