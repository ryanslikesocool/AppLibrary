import Combine
import Foundation

public enum Event { }

public extension Event {
	static let refreshApps = PassthroughSubject<Void, Never>()
	static let activateSearch = PassthroughSubject<Void, Never>()
}
