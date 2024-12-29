import AppLibraryCommon
import AppLibraryStorage
import Combine
import Foundation
import OSLog

@MainActor
public final class ApplicationCache: Observable {
	@Published public internal(set) var state: ApplicationCacheState
	@Published public internal(set) var applications: OrderedDictionary<ApplicationModelIdentifier, ApplicationModel>

	public init() {
		state = .idle
		applications = [:]
	}
}

// MARK: - Constants

extension ApplicationCache {
	nonisolated static let logger: Logger = Logger(category: ApplicationCache.self)

	/// The shared application cache instance.
	public static let shared: ApplicationCache = ApplicationCache()
}
