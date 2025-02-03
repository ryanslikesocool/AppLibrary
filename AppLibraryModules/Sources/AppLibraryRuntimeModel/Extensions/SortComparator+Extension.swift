import Foundation

public extension SortComparator where
	Self == KeyPathComparator<ApplicationInstance>
{
	static var version: Self {
		Self(
			\.version,
			comparator: .localizedStandard
		)
	}
}
