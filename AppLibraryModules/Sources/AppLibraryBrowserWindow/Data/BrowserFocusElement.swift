import AppLibraryStorage

enum BrowserFocusElement {
	case search
	case app(ApplicationModelIdentifier)
//	case group(ApplicationGroup)
}

// MARK: - Sendable

extension BrowserFocusElement: Sendable { }

// MARK: - Equatable

extension BrowserFocusElement: Equatable { }

// MARK: - Hashable

extension BrowserFocusElement: Hashable { }

// MARK: - Identifiable

extension BrowserFocusElement: Identifiable {
	var id: String {
		switch self {
			case .search: "AppLibrary.Search"
			case let .app(app): app.bundleIdentifier
//			case let .group(group): group.rawValue
		}
	}
}
