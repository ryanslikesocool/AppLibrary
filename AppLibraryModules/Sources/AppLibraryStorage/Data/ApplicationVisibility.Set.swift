import AppLibraryCommon

public extension ApplicationVisibility {
	/// An efficient set of ``ApplicationVisibility``.
	struct Set: EnumOptionSet {
		public typealias Enum = ApplicationVisibility

		public let rawValue: RawValue

		public init(rawValue: RawValue) {
			self.rawValue = rawValue
		}
	}
}

// MARK: - Sendable

extension ApplicationVisibility.Set: Sendable { }

// MARK: - Equatable

extension ApplicationVisibility.Set: Equatable { }

// MARK: - Hashable

extension ApplicationVisibility.Set: Hashable { }

// MARK: - Codable

extension ApplicationVisibility.Set: Codable { }

// MARK: - CaseIterable

extension ApplicationVisibility.Set: CaseIterable { }

// MARK: - Constants

public extension ApplicationVisibility.Set {
	/// The application is not visible in any contexts.
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

	/// The application visible in all contexts.
	///
	/// This is equivalent to ``all``.
	static let visible: Self = Self.all
}
