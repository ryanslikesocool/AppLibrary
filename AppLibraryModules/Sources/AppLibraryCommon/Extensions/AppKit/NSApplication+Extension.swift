import AppKit
import BundleToolbox

public extension NSApplication {
	var appName: String {
		(try? Bundle.main.object(forInfoDictionaryKey: .cfBundleName))
			?? ProcessInfo.processInfo.processName
	}
}
