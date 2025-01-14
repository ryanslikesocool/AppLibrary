import AppLibraryCommon
import Foundation

public extension [ApplicationModelIdentifier: ApplicationVisibility.Set] {
	static let `default`: Self = [
		ApplicationModelIdentifier(bundleIdentifier: Bundle.main.bundleIdentifier!): .hidden,
		ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-AirDrop"): .hidden,
		ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Computer"): .hidden,
		ApplicationModelIdentifier(bundleIdentifier: "com.apple.finder.Open-Recents"): .hidden,
	]
}
