public enum ExecutableArchitecture: String {
	case x86_64
	case arm64

	// TODO: Should arbitrary executable architectures be supported?
//	case some(String)
	// Or should other executable architectures all fall under a single "unknown" case?
//	case unknown
}

// MARK: - Sendable

extension ExecutableArchitecture: Sendable { }

// MARK: - Equatable

extension ExecutableArchitecture: Equatable { }

// MARK: - Hashable

extension ExecutableArchitecture: Hashable { }

// MARK: - CaseIterable

extension ExecutableArchitecture: CaseIterable { }
