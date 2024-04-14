import AppLibraryCommon
import AppLibraryStorage
import Combine

extension Event {
	static let scrollToApp = PassthroughSubject<ApplicationIdentifier, Never>()
}
