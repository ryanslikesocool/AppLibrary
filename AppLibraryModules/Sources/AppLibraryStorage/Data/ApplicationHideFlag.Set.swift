import AppLibraryCommon

public extension ApplicationHideFlag {
	typealias Set = EnumOptionSet<ApplicationHideFlag>
}

// MARK: - Constants

public extension ApplicationHideFlag.Set {
	static let none: Self = []

	static let hiddenInBrowser: Self = Self(.hiddenInBrowser)
	static let hiddenInSearch: Self = Self(.hiddenInSearch)

	static let all: Self = [.hiddenInBrowser, .hiddenInSearch]
}
