import AppLibraryCommon
import SwiftUI

@MainActor
@propertyWrapper
public struct SingletonFileObjectProperty<Model, Value>: DynamicProperty where
	Model: SingletonFileProtocol
{
	@ObservedObject
	private var model: Model

	private let keyPath: ReferenceWritableKeyPath<Model, Value>

	public var wrappedValue: Value {
		get { model[keyPath: keyPath] }
		nonmutating set {
			model[keyPath: keyPath] = newValue
			
			// TODO: Figure out a better way to save.
			// We don't really want to write on *every single change*.
			model.write()
		}
	}

	public var projectedValue: Binding<Value> {
		Binding(
			get: { wrappedValue },
			set: { newValue in wrappedValue = newValue }
		)
	}

	public init(
		_ model: Model,
		_ keyPath: ReferenceWritableKeyPath<Model, Value>
	) {
		self.model = model
		self.keyPath = keyPath
	}
}

// MARK: - Convenience

public extension SingletonFileObjectProperty {
	init(
		_ keyPath: ReferenceWritableKeyPath<Model, Value>
	) {
		self.init(
			Model.shared,
			keyPath
		)
	}
}
