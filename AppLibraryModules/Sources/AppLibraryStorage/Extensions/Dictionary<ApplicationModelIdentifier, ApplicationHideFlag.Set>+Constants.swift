import AppLibraryCommon
import Foundation

public extension [ApplicationModelIdentifier: ApplicationHideFlag.Set] {
	static let `default`: Self = [
		ApplicationModelIdentifier(bundleIdentifier: Bundle.main.bundleIdentifier!): .all,
	]
}