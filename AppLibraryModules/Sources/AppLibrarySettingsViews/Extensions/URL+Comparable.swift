import Foundation

extension URL: Comparable {
	public static func < (lhs: URL, rhs: URL) -> Bool {
		lhs.path(percentEncoded: false).localizedStandardCompare(rhs.path(percentEncoded: false)) == .orderedAscending
	}
}
