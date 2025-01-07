import AppLibraryCommon
import AppLibraryStorage
import Combine

extension Event {
	@MainActor static let scrollToApp = PassthroughEvent<ApplicationModelIdentifier>()
}
