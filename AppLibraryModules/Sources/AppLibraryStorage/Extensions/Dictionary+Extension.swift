import Foundation
import NSMetadataToolbox

extension Dictionary where
	Value == [NSMetadataItem]
{
	init<S, Attribute>(grouping metadataItems: S, at attribute: Attribute, by keyForValue: (Attribute.Output) throws -> Key) rethrows where
		S: Sequence,
		S.Element == NSMetadataItem,
		Attribute: NSMetadataAttributeProtocol,
		Attribute.Input == S.Element
	{
		try self.init(grouping: metadataItems) { (element: NSMetadataItem) -> Key in
			try keyForValue(element.value(forAttribute: attribute))
		}
	}

	init<S, Attribute>(grouping metadataItems: S, by attribute: Attribute) where
		S: Sequence,
		S.Element == NSMetadataItem,
		Attribute: NSMetadataAttributeProtocol,
		Attribute.Input == S.Element,
		Attribute.Output == Key
	{
		self.init(grouping: metadataItems) { (element: S.Element) -> Key in
			element.value(forAttribute: attribute)
		}
	}
}
