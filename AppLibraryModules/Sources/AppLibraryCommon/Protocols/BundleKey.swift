public protocol BundleKey {
	associatedtype Value

	static var key: String { get }
}