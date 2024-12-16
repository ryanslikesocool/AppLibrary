import Foundation

extension NSMetadataQuery {
	func results<Result>(as resultType: Result.Type) -> [Result] {
		results.compactMap { element -> Result? in
			element as? Result
		}
	}
}
