import Foundation
import SwiftUI

public enum Event { }

public extension Event {
	@MainActor static let refreshApps = PassthroughEvent<Void>()
	@MainActor static let activateSearch = PassthroughEvent<Void>()
	@MainActor static let moveCommand = PassthroughEvent<MoveCommandDirection>()
	@MainActor static let submitCommand = PassthroughEvent<Void>()
	@MainActor static let exitCommand = PassthroughEvent<Void>()
}
