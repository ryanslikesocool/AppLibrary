import AppLibraryStorage
import SwiftUI

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
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension NavigationDirection: CaseIterable { }

// MARK: - Convenience

extension NavigationDirection {
	public init?(keyCode: UInt16) {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should we store this as a `static let keyCodeInitializerLookupTable: [KeyCode : Self]`?
		// - Should `switch` cases be `case Self.<case>.keyCode:` for safety?

		self.init(where: \.keyCode, equals: keyCode)
	}

	public init?(keyEquivalent: KeyEquivalent) {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should we store this as a `static let keyEquivalentInitializerLookupTable: [KeyEquivalent : Self]`?
		// - Should `switch` cases be `case Self.<case>.keyEquivalent:` for safety?

		self.init(where: \.keyEquivalent, equals: keyEquivalent)
	}
}

// MARK: -

extension NavigationDirection {
	public var keyCode: UInt16 {
		switch self {
			case .left: 0x7B
			case .right: 0x7C
			case .down: 0x7D
			case .up: 0x7E
		}
	}

	public var keyEquivalent: KeyEquivalent {
		switch self {
			case .left: .leftArrow
			case .right: .rightArrow
			case .down: .downArrow
			case .up: .upArrow
		}
	}

	public func offset(for layout: LibraryLayout) -> Int {
		switch (self, layout) {
			case (.left, _): -1
			case (.right, _): 1
			case let (.down, some): some.xDimension
			case let (.up, some): -some.xDimension
		}
	}

	public func getEntry<S>(
		ofType: S.Element.Type = S.Element.self
	) -> KeyPath<S, S.Element?> where
		S: BidirectionalCollection
	{
		switch self {
			case .left: \.last
			case .right: \.first
			case .down: \.first
			case .up: \.last
		}
	}

	public var axis: Axis {
		switch self {
			case .left, .right: .horizontal
			case .down, .up: .vertical
		}
	}
}
