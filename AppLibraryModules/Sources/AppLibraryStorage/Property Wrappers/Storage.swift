import SwiftUI

public typealias Storage<Model, Value> = SingletonFileObjectProperty<Model, Value> where
	Model: SingletonFileProtocol
