import Combine
import Foundation

public enum Event { }

public extension Event {
	static let refreshApps = PassthroughSubject<Void, Never>()
}
