import AppLibraryStorage

enum FocusElement {
	case search
	case app(ApplicationModelIdentifier)
	case group(ApplicationGroup)
}

// MARK: - Equatable

extension FocusElement: Equatable { }

// MARK: - Hashable

extension FocusElement: Hashable { }

// MARK: - Identifiable

extension FocusElement: Identifiable {
	var id: String {
		switch self {
			case .search: "AppLibrary.Search"
			case let .app(app): app.bundleIdentifier
			case let .group(group): group.rawValue
		}
	}
}
