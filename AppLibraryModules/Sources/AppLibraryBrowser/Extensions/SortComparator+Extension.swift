import AppLibraryStorage
import Foundation

extension SortComparator where
	Self == KeyPathComparator<Application>
{
	static func localizedStandard(_ keyPath: KeyPath<Compared, String>) -> Self {
		KeyPathComparator(keyPath, comparator: String.Comparator.localizedStandard)
	}
}
