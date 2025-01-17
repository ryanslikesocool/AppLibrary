public extension Storage where
	Model == GeneralSettings
{
	/// Access a property in the app's ``GeneralSettings``.
	///
	/// - Parameter keyPath: The key path to the property to access.
	init(general keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(keyPath)
	}
}

public extension Storage where
	Model == AppsSettings
{
	/// Access a property in the app's ``AppsSettings``.
	///
	/// - Parameter keyPath: The key path to the property to access.
	init(apps keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(keyPath)
	}
}

public extension Storage where
	Model == LayoutSettings
{
	/// Access a property in the app's ``LayoutSettings``.
	///
	/// - Parameter keyPath: The key path to the property to access.
	init(layout keyPath: ReferenceWritableKeyPath<Model, Value>) {
		self.init(keyPath)
	}
}
