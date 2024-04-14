import AppLibraryStorage

enum NavigationDirection: UInt8 {
	case left
	case right
	case down
	case up
}

// MARK: - Sendable

extension NavigationDirection: Sendable { }

// MARK: - Equatable

extension NavigationDirection: Equatable { }

// MARK: - Hashable

extension NavigationDirection: Hashable { }

// MARK: - Identifiable

extension NavigationDirection: Identifiable {
	var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension NavigationDirection: CaseIterable { }

// MARK: - Key Code

extension NavigationDirection {
	var keyCode: UInt16 {
		switch self {
			case .left: 0x7B
			case .right: 0x7C
			case .down: 0x7D
			case .up: 0x7E
		}
	}

	init?(keyCode: UInt16) {
		guard let value = Self.allCases.first(where: { $0.keyCode == keyCode }) else {
			return nil
		}
		self = value
	}
}

// MARK: -

extension NavigationDirection {
	func offset(for layout: LibraryLayout) -> Int {
		switch (self, layout) {
			case (.left, _): -1
			case (.right, _): 1
			case let (.down, some): some.xDimension
			case let (.up, some): -some.xDimension
			default: preconditionFailure()
		}
	}

	var entryIndex: KeyPath<Range<Int>, Int?> {
		switch self {
			case .left: \.last
			case .right: \.first
			case .down: \.first
			case .up: \.last
			default: preconditionFailure()
		}
	}

	var isHorizontal: Bool {
		switch self {
			case .left, .right: true
			case .down, .up: false
			default: preconditionFailure()
		}
	}

	var isVertical: Bool {
		switch self {
			case .left, .right: false
			case .down, .up: true
			default: preconditionFailure()
		}
	}
}
