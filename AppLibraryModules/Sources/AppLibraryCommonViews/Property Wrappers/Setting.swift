import AppLibraryStorage
import SwiftUI

@propertyWrapper
public struct Setting<Model: SettingsFile, Value>: DynamicProperty {
	@ObservedObject private var model: Model = .shared
	private let keyPath: ReferenceWritableKeyPath<Model, Value>

	public var wrappedValue: Value {
		get { model[keyPath: keyPath] }
		nonmutating set {
			model[keyPath: keyPath] = newValue

			// TODO: instead of writing on every change, only write after a certain time interval or when entering background
			model.save()
		}
	}

	public var projectedValue: Binding<Value> {
		Binding<Value>(
			get: { wrappedValue },
			set: { wrappedValue = $0 }
		)
	}

	fileprivate init(_ model: Model.Type, keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.keyPath = keyPath
	}
}

// MARK: - GeneralSettings

public extension Setting where Model == GeneralSettings {
	init(general keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath: keyPath)
	}
}

// MARK: - AppsSettings

public extension Setting where Model == AppsSettings {
	init(apps keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath: keyPath)
	}
}

// MARK: - LayoutSettings

public extension Setting where Model == LayoutSettings {
	init(layout keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(Model.self, keyPath: keyPath)
	}
}
