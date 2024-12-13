import AppLibraryCommon
import SwiftUI

@MainActor
@propertyWrapper
public struct Storage<File, Value>: DynamicProperty {
	public typealias KeyPath = any WritableKeyPath<File, Value> & Sendable

	@ObservedObject
	private var file: ObservingCurrentValue<File>

	private let keyPath: KeyPath

	public var wrappedValue: Value {
		get { file.wrappedValue[keyPath: keyPath] }
		nonmutating set { file.wrappedValue[keyPath: keyPath] = newValue }
	}

	public var projectedValue: Binding<Value> {
		Binding(
			get: { wrappedValue },
			set: { newValue in wrappedValue = newValue }
		)
	}

	public init(
		_ file: ObservingCurrentValue<File>,
		_ keyPath: KeyPath
	) {
		self.file = file
		self.keyPath = keyPath
	}
}
