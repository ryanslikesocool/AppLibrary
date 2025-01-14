public enum ApplicationModelView: UInt8 {
	/// The "preferred" application model view.
	/// By default, this displays the most recent version of an application.
	case preferred

	/// The "instances" application model view.
	/// This displays all instances of an application.
	case instances
}

// MARK: - Sendable

extension ApplicationModelView: Sendable { }

// MARK: - Equatable

extension ApplicationModelView: Equatable { }

// MARK: - Hashable

extension ApplicationModelView: Hashable { }

// MARK: - Identifiable

extension ApplicationModelView: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - Codable

extension ApplicationModelView: Codable { }

// MARK: - CaseIterable

extension ApplicationModelView: CaseIterable { }
