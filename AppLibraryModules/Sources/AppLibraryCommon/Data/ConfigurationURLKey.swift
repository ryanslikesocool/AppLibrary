public enum ConfigurationURLKey: String {
	case projectHomepage = "ProjectHomepage"
}

// MARK: - Sendable

extension ConfigurationURLKey: Sendable { }

// MARK: - Equatable

extension ConfigurationURLKey: Equatable { }

// MARK: - Hashable

extension ConfigurationURLKey: Hashable { }