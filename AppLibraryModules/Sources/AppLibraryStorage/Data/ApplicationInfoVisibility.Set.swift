import AppLibraryCommon

public extension ApplicationInfoVisibility {
	/// An efficient set of ``ApplicationInfoVisibility``.
	struct Set: EnumOptionSet {
		public typealias Enum = ApplicationInfoVisibility

		public let rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension ApplicationInfoVisibility.Set: Sendable { }

// MARK: - Equatable

extension ApplicationInfoVisibility.Set: Equatable { }

// MARK: - Hashable

extension ApplicationInfoVisibility.Set: Hashable { }

// MARK: - Codable

extension ApplicationInfoVisibility.Set: Codable { }

// MARK: - CaseIterable

extension ApplicationInfoVisibility.Set: CaseIterable { }

// MARK: - Constants

public extension ApplicationInfoVisibility.Set {
	/// The application instance path.
	///
	/// ## See Also
	/// - ``ApplicationInfoVisibility/path``
	static let path: Self = Self(.path)

	/// The application instance version.
	///
	/// ## See Also
	/// - ``ApplicationInfoVisibility/version``
	static let version: Self = Self(.version)

	/// The application instance architectures.
	///
	/// ## See Also
	/// - ``ApplicationInfoVisibility/architectures``
	static let architectures: Self = Self(.architectures)

	/// An indicator showing if an instance of the application is currently open.
	///
	/// ## See Also
	/// - ``ApplicationInfoVisibility/openIndicator``
	static let openIndicator: Self = Self(.openIndicator)
}
