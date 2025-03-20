import Foundation

public extension URL {
	struct PathComparator: SortComparator {
		public typealias Compared = URL

		private var stringComparator: String.StandardComparator

		public var order: SortOrder {
			get { stringComparator.order }
			set { stringComparator.order = newValue }
		}

		public init(
			base: String.StandardComparator = .localizedStandard,
			order: SortOrder = .forward
		) {
			stringComparator = String.StandardComparator(base, order: order)
		}

		public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
			stringComparator.compare(lhs.path(), rhs.path())
		}
	}
}

// MARK: - Convenience

public extension SortComparator where
	Self == URL.PathComparator
{
	static func path(
		base: String.StandardComparator = .localizedStandard,
		order: SortOrder = .forward
	) -> Self {
		Self(base: base, order: order)
	}
}
