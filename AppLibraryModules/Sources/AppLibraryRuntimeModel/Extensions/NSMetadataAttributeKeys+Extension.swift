import AppLibraryStorage
import Foundation
import NSMetadataToolbox

public extension NSMetadataAttributeKeys.ExecutableArchitectures {
	func asEnums() -> some NSMetadataAttributeObject<Input, [ExecutableArchitecture]?> {
		map { (input: [String]?) -> [ExecutableArchitecture]? in
			input?.compactMap(ExecutableArchitecture.init(rawValue:))
		}
	}
}

public extension NSMetadataAttributeKeys.AppStoreCategoryType {
	func asEnum() -> some NSMetadataAttributeObject<Input, AppStoreCategoryType?> {
		map { (input: String?) -> AppStoreCategoryType? in
			guard let input else {
				return nil
			}
			return AppStoreCategoryType(rawValue: input)
		}
	}
}

public extension NSMetadataAttributeKeys.Keywords {
	func componentSet() -> some NSMetadataAttributeObject<Input, Set<String>?> {
		map(ApplicationModel.separateApplicationKeywords(_:))
	}
}
