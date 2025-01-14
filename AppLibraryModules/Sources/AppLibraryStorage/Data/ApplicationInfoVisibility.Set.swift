import AppLibraryCommon

public extension ApplicationInfoVisibility {
	/// An efficient set of ``ApplicationInfoVisibility``.
	typealias Set = EnumOptionSet<Self>
}

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
}