public extension Storage where
	File == GeneralSettings
{
	init(general keyPath: any WritableKeyPath<File, Value> & Sendable) {
		self.init(File.$shared, keyPath)
	}
}

public extension Storage where
	File == AppsSettings
{
	init(apps keyPath: any WritableKeyPath<File, Value> & Sendable) {
		self.init(File.$shared, keyPath)
	}
}

public extension Storage where
	File == LayoutSettings
{
	init(layout keyPath: any WritableKeyPath<File, Value> & Sendable) {
		self.init(File.$shared, keyPath)
	}
}