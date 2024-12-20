public protocol BundleInfoDictionaryKey {
	associatedtype Value

	static var infoDictionaryKey: String { get }
}
