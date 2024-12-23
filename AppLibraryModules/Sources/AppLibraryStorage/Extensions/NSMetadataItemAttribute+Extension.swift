import Foundation
import NSMetadataToolbox

public extension NSMetadataAttribute.ExecutableArchitecturesKey {
	func asEnums() -> some NSMetadataAttributeProtocol<Input, [ExecutableArchitecture]?> {
		map { (input: [String]?) -> [ExecutableArchitecture]? in
			input?.compactMap(ExecutableArchitecture.init(rawValue:))
		}
	}
}

public extension NSMetadataAttribute.AppStoreCategoryTypeKey {
	func asEnum() -> some NSMetadataAttributeProtocol<Input, AppStoreCategoryType?> {
		map { (input: String?) -> AppStoreCategoryType? in
			guard let input else {
				return nil
			}
			return AppStoreCategoryType(rawValue: input)
		}
	}
}

public extension NSMetadataAttribute.KeywordsKey {
	func componentSet() -> some NSMetadataAttributeProtocol<Input, Set<String>?> {
		map(ApplicationModel.separateApplicationKeywords(_:))
	}
}
