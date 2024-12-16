import Foundation

public extension SortComparator where
	Self == KeyPathComparator<Application>
{
	static func localizedStandard(_ keyPath: any KeyPath<Compared, String> & Sendable) -> Self {
		KeyPathComparator(keyPath, comparator: String.Comparator.localizedStandard)
	}
}
