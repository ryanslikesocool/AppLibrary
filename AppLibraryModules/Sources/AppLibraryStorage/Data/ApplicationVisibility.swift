import AppIntents
import AppLibraryResources
import Foundation

/// Constants that determine where an application is displayed.
public enum ApplicationVisibility: UInt8 {
	/// The application is visible in the browser.
	///
	/// ## See Also
	/// - ``Set/browser``
	case browser

	/// The application appears in search results.
	///
	/// ## See Also
	/// - ``Set/searchResults``
	case searchResults
}

// MARK: - Sendable

extension ApplicationVisibility: Sendable { }

// MARK: - Equatable

extension ApplicationVisibility: Equatable { }

// MARK: - Hashable

extension ApplicationVisibility: Hashable { }

// MARK: - Identifiable

extension ApplicationVisibility: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ApplicationVisibility: Codable { }

// MARK: - CaseIterable

extension ApplicationVisibility: CaseIterable { }

// MARK: - CaseDisplayRepresentable

extension ApplicationVisibility: CaseDisplayRepresentable {
	public static let caseDisplayRepresentations: [Self: DisplayRepresentation] = [
		.browser: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.BROWSER_\(LocalizedStringResource.browserWindow.title)", table: Self.localizationTable),
		),

		.searchResults: DisplayRepresentation(
			title: LocalizedStringResource("ITEM.SEARCH_RESULTS", table: Self.localizationTable),
		),
	]
}

// MARK: - Constants

private extension ApplicationVisibility {
	static let localizationTable = "ApplicationVisibilityPicker"
}
