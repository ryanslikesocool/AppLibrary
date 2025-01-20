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

// MARK: -

public extension ApplicationCache {
	/// - Parameter keys: The keys of the values to access.
	func values<S>(
		for keys: S
	) -> [ApplicationModel] where
		S: Sequence,
		S.Element == ApplicationModelIdentifier
	{
		keys.compactMap(applications.value(for:))
	}
}