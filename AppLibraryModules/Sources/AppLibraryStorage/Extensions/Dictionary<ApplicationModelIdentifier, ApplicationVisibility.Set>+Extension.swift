import AppLibraryCommon
import Foundation

public extension [ApplicationModelIdentifier: ApplicationVisibility.Set] {
	static let `default`: Self = {
		var result: Self = [
			// App Library
			ApplicationModelIdentifier(bundleIdentifier: Bundle.main.bundleIdentifier!): .searchResults,

			// Finder launchers
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-AirDrop"): .searchResults,
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-AllMyFiles"): .searchResults,
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Computer"): .searchResults,
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-iCloudDrive"): .searchResults,
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Network"): .searchResults,
			ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Recents"): .searchResults,

			// Is this petty?
//			ApplicationModelIdentifier(bundleIdentifier: "com.apple.launchpad.launcher"): .hidden,
		]

		if ExecutableArchitecture.arm64 == .current {
			// Apple Silicon only
			result[ApplicationModelIdentifier(bundleIdentifier: "com.apple.bootcampassistant")] = .hidden
		}

		return result
	}()
}
