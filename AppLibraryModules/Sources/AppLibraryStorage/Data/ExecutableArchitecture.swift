public enum ExecutableArchitecture: String {
	case x86_64
	case arm64
}

// MARK: - Sendable

extension ExecutableArchitecture: Sendable { }

// MARK: - Equatable

extension ExecutableArchitecture: Equatable { }

// MARK: - Hashable

extension ExecutableArchitecture: Hashable { }

// MARK: - CaseIterable

extension ExecutableArchitecture: CaseIterable { }
