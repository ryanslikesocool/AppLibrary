import Foundation
import AppLibraryStorage

public extension Application {
	struct StandardComparator: SortComparator {
		public typealias Compared = Application

		public var order: SortOrder

		public init(order: SortOrder = .forward) {
			self.order = order
		}

		public func compare(_ lhs: Compared, _ rhs: Compared) -> ComparisonResult {
			fatalError("\(Self.self).\(#function) is not implemented")
		}
	}
}