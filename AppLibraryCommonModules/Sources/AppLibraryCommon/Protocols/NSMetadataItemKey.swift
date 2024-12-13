import Foundation

public protocol NSMetadataItemKey {
	associatedtype Value

	static var key: String { get }
}
