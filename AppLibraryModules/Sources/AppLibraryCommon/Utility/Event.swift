import Foundation

public enum Event { }

public extension Event {
	@MainActor static let refreshApps = PassthroughEvent<Void>()
	@MainActor static let activateSearch = PassthroughEvent<Void>()
}
