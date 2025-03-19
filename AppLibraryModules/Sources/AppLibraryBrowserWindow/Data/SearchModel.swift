import AppLibraryCommon
import AppLibraryRuntimeModel

struct SearchModel {
	public var query: String

	public init() {
		query = ""
	}
}

// MARK: - Equatable

// extension SearchModel: Equatable { }

// MARK: - Hashable

// extension SearchModel: Hashable { }

// MARK: - FilterProtocol

extension SearchModel: @preconcurrency FilterProtocol {
	public typealias Subject = ApplicationModel

	@MainActor
	public func filter(subjects: [Subject]) -> [Subject] {
		var result = subjects

		if query.isEmpty {
			result = result.filter { subject in
				subject.configuration.visibilityFlags.contains(.browser)
			}
		} else {
			result = result.filter { subject in
				subject.configuration.visibilityFlags.contains(.searchResults)
					&& subject.displayName.localizedStandardContains(query)
			}
		}

		return result
	}
}

// MARK: - AppLibraryCommon.SearchModel

extension SearchModel: AppLibraryCommon.SearchModel { }
