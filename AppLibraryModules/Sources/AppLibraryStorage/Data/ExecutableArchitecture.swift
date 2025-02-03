// TODO: Should this be converted to a `struct`?

public enum ExecutableArchitecture: String {
	/// Specifies the 32-bit PowerPC architecture.
//	@available(macOS, deprecated: 10.6)
	case ppc

	/// Specifies the 64-bit PowerPC architecture.
//	@available(macOS, deprecated: 10.6)
	case ppc64

	/// Specifies the 32-bit Intel architecture.
//	@available(macOS, introduced: 10.4, deprecated: 10.15)
	case i386

	/// Specifies the 64-bit Intel architecture.
//	@available(macOS 10.4, *)
	case x86_64

	/// Specifies the 32-bit ARM architecture.
//	@available(macOS, unavailable)
	case arm

	/// Specifies the 64-bit ARM architecture.
//	@available(macOS 11, *)
	case arm64
}

// MARK: - Sendable

extension ExecutableArchitecture: Sendable { }

// MARK: - Equatable

extension ExecutableArchitecture: Equatable { }

// MARK: - Hashable

extension ExecutableArchitecture: Hashable { }

// MARK: - Identifiable

extension ExecutableArchitecture: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension ExecutableArchitecture: CaseIterable { }

// MARK: - Constants

public extension ExecutableArchitecture {
	static var current: Self {
#if arch(i386)
		.i386
#elseif arch(x86_64)
		.x86_64
#elseif arch(arm)
		.arm
#elseif arch(arm64)
		.arm64
#else
		preconditionFailure("Running on an unexpected architecture.  Please file a bug report.")
#endif
	}
}
