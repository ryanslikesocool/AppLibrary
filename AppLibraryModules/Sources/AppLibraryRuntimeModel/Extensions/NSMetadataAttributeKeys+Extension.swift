import AppLibraryStorage
import Foundation
import NSMetadataToolbox

public extension NSMetadataAttributeKeys.ExecutableArchitectures {
	/// Transform the result of ``NSMetadataAttributeKeys.ExecutableArchitectures`` to `[ExecutableArchitecture]`.
	func asEnums() -> some NSMetadataAttributeObject<Input, [ExecutableArchitecture]> {
		map { (input: [String]) -> [ExecutableArchitecture] in
			input.compactMap(ExecutableArchitecture.init(rawValue:))
		}
	}
}

public extension NSMetadataAttributeKeys.AppStoreCategoryType {
	/// Transform the result of ``NSMetadataAttributeKeys.AppStoreCategoryType`` to `AppStoreCategoryType?`.
	func asEnum() -> some NSMetadataAttributeObject<Input, AppStoreCategoryType?> {
		map(AppStoreCategoryType.init(rawValue:))
	}
}

public extension NSMetadataAttributeKeys.Keywords {
	/// Transform the result of ``NSMetadataAttributeKeys.Keywords`` to `Set<String>`.
	func componentSet() -> some NSMetadataAttributeObject<Input, Set<String>> {
		map(ApplicationModel.separateApplicationKeywords(_:))
	}
}
