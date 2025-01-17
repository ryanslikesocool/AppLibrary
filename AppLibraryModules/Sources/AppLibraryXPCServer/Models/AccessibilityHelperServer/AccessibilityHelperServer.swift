import AppLibraryAccessibilityHelperShared
import AppLibraryExtensionCommon
import AppLibraryExtensionServer
import OSLog
import XPCToolbox

@MainActor
public final class AccessibilityHelperServer: AppLibraryXPCServer {
	override public class var serviceName: XPCServiceName { .accessibilityHelper }
}

// MARK: - Constants

public extension AccessibilityHelperServer {
	static let shared: AccessibilityHelperServer = try! AccessibilityHelperServer()
}

extension AccessibilityHelperServer {
	nonisolated static let logger = Logger(category: AccessibilityHelperServer.self)

	typealias Message = AccessibilityHelperMessage

	typealias Request = Message.Request
	typealias Response = Message.Response
}
