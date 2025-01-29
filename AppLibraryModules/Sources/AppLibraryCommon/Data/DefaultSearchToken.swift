public enum DefaultSearchToken<Subject> { }

// MARK: - Sendable

extension DefaultSearchToken: Sendable { }

// MARK: - Equatable

extension DefaultSearchToken: Equatable { }

// MARK: - Hashable

extension DefaultSearchToken: Hashable { }

// MARK: - Identifiable

extension DefaultSearchToken: Identifiable {
	public var id: Int {
		// NOTE: This type only needs to be unique against itself in a single runtime.
		// The `hashValue` will suffice
		hashValue
	}
}

// MARK: - SearchToken

extension DefaultSearchToken: SearchToken {
	public func filter(subjects: [Subject]) -> [Subject] {
		subjects
	}
}
