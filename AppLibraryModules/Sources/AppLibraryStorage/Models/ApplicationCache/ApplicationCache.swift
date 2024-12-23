import AppLibraryCommon
import Combine
import Foundation
import OSLog

@MainActor
public final class ApplicationCache: Observable {
	@Published public internal(set) var state: ApplicationCacheState
	@Published public internal(set) var applications: OrderedDictionary<ApplicationModelIdentifier, ApplicationModel>

	public var delegate: ApplicationCacheDelegate?

	public init() {
		state = .idle
		applications = [:]
	}
}

// MARK: - Constants

extension ApplicationCache {
	static let logger: Logger = Logger(category: ApplicationCache.self)

	public static let shared: ApplicationCache = ApplicationCache()
}
