import BundleToolbox
import DeclarativeCore
import Foundation

public enum XCConfiguration {
	public static subscript<Key>(key: Key, in bundle: Bundle = .main) -> Key.Output where
		Key: XCConfigurationKey
	{
		get throws {
			try bundle.object(forInfoDictionaryKey: key)
		}
	}
}
