import SwiftUI

public typealias StorageFile<Model> = SingletonFileObject<Model> where
	Model: SingletonFileProtocol & ObservableObject
