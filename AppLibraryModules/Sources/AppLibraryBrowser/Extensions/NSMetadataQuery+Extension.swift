import Foundation

extension NSMetadataQuery {
	func results<Element>(as elementType: Element.Type) -> [Element] {
		results.compactMap { element in
			element as? Element
		}
	}
}