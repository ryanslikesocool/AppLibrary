import AppLibraryCommon

public extension ApplicationVisibility {
	/// An efficient set of ``ApplicationVisibility``.
	typealias Set = EnumOptionSet<Self>
}

// MARK: - Constants

public extension ApplicationVisibility.Set {
	/// The application is not visible.
	///
	/// This is equivalent to ``none``.
	static let hidden: Self = Self.none

	/// The application is visible in the browser.
	///
	/// ## See Also
	/// ``ApplicationVisibility/browser``
	static let browser = Self(.browser)

	/// The application appears in search results.
	///
	/// ## See Also
	/// ``ApplicationVisibility/searchResults``
	static let searchResults = Self(.searchResults)
}