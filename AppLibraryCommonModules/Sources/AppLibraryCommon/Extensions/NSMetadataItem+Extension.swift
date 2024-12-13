import ExceptionCatcher
import Foundation

public extension NSMetadataItem {
	subscript<Key>(key: Key.Type) -> Key.Value where
		Key: NSMetadataItemKey
	{
		get throws {
			let metadataValue = try ExceptionCatcher.catch(callback: { self.value(forKey: Key.key) })
			guard let safeValue = metadataValue as? Key.Value else {
				throw CommonError.castFailure(from: metadataValue, to: Key.Value.self)
			}
			return safeValue
		}
	}
}
