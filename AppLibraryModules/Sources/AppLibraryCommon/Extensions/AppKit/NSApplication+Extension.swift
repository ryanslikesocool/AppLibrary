import AppKit
import BundleToolbox

public extension NSApplication {
	var applicationName: String {
		(try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName))
			?? ProcessInfo.processInfo.processName
	}
}
