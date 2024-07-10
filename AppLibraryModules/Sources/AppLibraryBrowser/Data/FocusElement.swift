import AppLibraryStorage

enum FocusElement {
	case search
	case app(ApplicationIdentifier)
	case group(ApplicationGroup)
}

// MARK: - Hashable

extension FocusElement: Hashable { }

// MARK: - Identifiable

extension FocusElement: Identifiable {
	var id: String {
		switch self {
			case .search: "AppLibrary.Search"
			case let .app(app): app.id
			case let .group(group): group.id
		}
	}
}
