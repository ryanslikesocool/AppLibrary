import Combine
import Foundation

public enum Event {
	public typealias Passthrough<each Output> = PassthroughSubject<(repeat each Output), Never>
}

public extension Event {
	@MainActor static let refreshApps = Passthrough<Void>()
	@MainActor static let activateSearch = Passthrough<Void>()
}
