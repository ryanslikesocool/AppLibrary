import Combine
import Foundation

public enum Event {
	public typealias Passthrough<each Output> = PassthroughSubject < (repeat each Output), Never>
}

public extension Event {
	static let refreshApps = Passthrough<Void>()
	static let activateSearch = Passthrough<Void>()
}
