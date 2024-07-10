import Foundation

public enum Constant {
	public static let applicationSupportDirectory: URL = URL.applicationSupportDirectory
		.appending(components: "Developed With Love", AppLibraryInformation.appName, directoryHint: .notDirectory)
}
