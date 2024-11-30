import Foundation

public extension Bundle {
	var bundleName: String? {
		object(forInfoDictionaryKey: kCFBundleNameKey as String) as? String
	}

	var bundleShortVersionString: String? {
		object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
	}

	var bundleVersionString: String? {
		object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
	}

	var humanReadableCopyright: String? {
		object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String
	}
}
