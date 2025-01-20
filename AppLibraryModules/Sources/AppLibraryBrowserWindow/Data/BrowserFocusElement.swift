import AppLibraryStorage
import AppLibraryRuntimeModel

enum BrowserFocusElement {
	case invalid
	case search
	case application(ApplicationModelIdentifier) // TODO: Change argument to `ApplicationInstanceIdentifier`
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
			case .invalid: "AppLibrary.Invalid"
			case .search: "AppLibrary.Search"
			case let .application(application): application.bundleIdentifier
//			case let .group(group): group.rawValue
		}
	}
}

// MARK: - Convenience

extension BrowserFocusElement {
	static func application(_ applicationModel: ApplicationModel) -> Self {
		Self.application(ApplicationModelIdentifier(applicationModel))
	}

//	static func application(_ applicationInstance: ApplicationInstance) -> Self {
//		Self.application(ApplicationInstanceIdentifier(applicationInstance))
//	}
}
