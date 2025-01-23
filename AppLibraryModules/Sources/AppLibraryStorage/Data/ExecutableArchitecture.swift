// TODO: Should this be converted to a `struct`?

public enum ExecutableArchitecture: String {
	/// Specifies the 32-bit PowerPC architecture.
	case ppc

	/// Specifies the 64-bit PowerPC architecture.
	case ppc64

	/// Specifies the 32-bit Intel architecture.
	case i386

	/// Specifies the 64-bit Intel architecture.
	case x86_64

	/// Specifies the 32-bit ARM architecture.
	case arm

	/// Specifies the 64-bit ARM architecture.
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

// MARK: -

public extension ExecutableArchitecture {
	static var current: Self {
#if arch(i386)
		.i386
#elseif arch(x86_64)
		.x86_86
#elseif arch(arm)
		.arm
#elseif arch(arm64)
		.arm64
#else
		preconditionFailure("Running on an unexpected architecture.  Please file a bug report.")
#endif
	}
}
