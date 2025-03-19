import AppLibraryCommon
import Foundation

public extension [ApplicationModelIdentifier: ApplicationVisibility.Set] {
	static var `default`: Self {
		[ApplicationModelIdentifier: ApplicationConfiguration].default
			.mapValues { configuration in
				configuration.visibilityFlags
			}
	}
}

public extension [ApplicationModelIdentifier: ApplicationConfiguration] {
	static var `default`: Self {
		var result: Self = [
			// App Library
			ApplicationModelIdentifier(bundleIdentifier: Bundle.main.bundleIdentifier!): ApplicationConfiguration(visibilityFlags: .searchResults),

			// Finder launchers
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-AirDrop"): ApplicationConfiguration(visibilityFlags: .searchResults),
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-AllMyFiles"): ApplicationConfiguration(visibilityFlags: .searchResults),
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Computer"): ApplicationConfiguration(visibilityFlags: .searchResults),
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-iCloudDrive"): ApplicationConfiguration(visibilityFlags: .searchResults),
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Network"): ApplicationConfiguration(visibilityFlags: .searchResults),
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Recents"): ApplicationConfiguration(visibilityFlags: .searchResults),

			// Is this petty?
//			ApplicationModelIdentifier(bundleIdentifier: "com.apple.launchpad.launcher"): ApplicationConfiguration(visibilityFlags: .hidden),
		]

		if ExecutableArchitecture.arm64 == .current {
			// Apple Silicon only
			result[ApplicationModelIdentifier(bundleIdentifier: "com.apple.bootcampassistant")] = ApplicationConfiguration(visibilityFlags: .hidden)
		}

		return result
	}
}
