import SwiftUI

@MainActor
@propertyWrapper
public struct SingletonFileObject<Model>: DynamicProperty where
	Model: SingletonFileProtocol
{
	@ObservedObject
	public var wrappedValue: Model {
		didSet {
			wrappedValue.write()
		}
	}

	public var projectedValue: ObservedObject<Model>.Wrapper {
		$wrappedValue
	}

	public init(
		_ wrappedValue: Model
	) {
		self.wrappedValue = wrappedValue
	}
}

// MARK: - Convenience

public extension SingletonFileObject {
	init(_ modelType: Model.Type = Model.self) {
		self.init(Model.shared)
	}
}
