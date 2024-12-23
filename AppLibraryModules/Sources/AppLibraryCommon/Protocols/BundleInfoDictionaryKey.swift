/// A key for accessing objects in a bundle's info dictionary.
public protocol BundleInfoDictionaryKey {
	associatedtype Value

	static var infoDictionaryKey: String { get }

	/// Process the attribute value before returning it from ``Foundation/Bundle/object(forInfoDictionaryKey:)``.
	static func process(infoDictionaryObject object: Any?) -> Value?
}

public extension BundleInfoDictionaryKey {
	static func process(infoDictionaryObject object: Any?) -> Value? {
		object as? Value
	}
}