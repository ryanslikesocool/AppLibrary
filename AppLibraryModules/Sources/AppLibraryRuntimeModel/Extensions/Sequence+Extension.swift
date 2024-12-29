import Foundation
import NSMetadataToolbox

extension Sequence where
	Element == ApplicationInstance
{
	func allBundleIdentifiersEqual(_ equalityValue: String) -> Bool {
		allSatisfy { (element: Element) -> Bool in
			(try? element.metadataItem.value(forAttribute: .cfBundleIdentifier)) == equalityValue
		}
	}
}