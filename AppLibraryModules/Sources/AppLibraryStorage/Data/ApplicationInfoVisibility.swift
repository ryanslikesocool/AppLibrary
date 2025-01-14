import Foundation

/// Constants that determine what application information is visible in the browser.
public enum ApplicationInfoVisibility: UInt8 {
	/// The application instance path.
	///
	/// ## See Also
	/// - ``Set/path``
	case path

	/// The application instance version.
	///
	/// ## See Also
	/// - ``Set/version``
	case version

	/// The application instance architectures.
	///
	/// ## See Also
	/// - ``Set/architectures``
	case architectures
}

// MARK: - Sendable

extension ApplicationInfoVisibility: Sendable { }

// MARK: - Equatable

extension ApplicationInfoVisibility: Equatable { }

// MARK: - Hashable

extension ApplicationInfoVisibility: Hashable { }

// MARK: - Identifiable

extension ApplicationInfoVisibility: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ApplicationInfoVisibility: Codable { }

// MARK: - CaseIterable

extension ApplicationInfoVisibility: CaseIterable { }

// MARK: - CustomLocalizedStringResourceConvertible

//extension ApplicationInfoVisibility: CustomLocalizedStringResourceConvertible {
//	public var localizedStringResource: LocalizedStringResource {
//		switch self {
//			case .path: .applicationInfoVisibilityPicker.item.path
//			case .version: .applicationInfoVisibilityPicker.item.version
//			case .architectures: .applicationInfoVisibilityPicker.item.architectures
//		}
//	}
//}