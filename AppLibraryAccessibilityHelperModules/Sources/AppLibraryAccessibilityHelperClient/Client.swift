import AppKit
import AppLibraryAccessibilityHelperCommon
import AppLibraryExtensionClient
import AppLibraryExtensionCommon
import CoreGraphics
import OSLog
import XPC
import XPCToolbox

@main
public struct Client: AppLibraryXPCClientProtocol {
	typealias Message = AccessibilityHelperMessage

	public static var xpcServiceName: XPCServiceName { .accessibilityHelper }

	public var listener: XPCListener? = nil

	public init() {
		Self.logger.info("Initialized XPC client `\(Self.self)`.")

		AccessibilityUtility.requestAccess()
	}

	public func handleSession(
		request: XPCListener.IncomingSessionRequest
	) -> XPCListener.IncomingSessionRequest.Decision {
		// When a session request arrives, you must either accept or reject it.
		// The listener invokes the closure you specify every time a
		// message is received.

		request.accept(
			incomingMessageHandler: performTask(with:)
		)
	}

	// The function that performs the work of the service.
	func performTask(with request: AccessibilityHelperMessage.Request) -> (any Encodable)? {
		Self.logger.debug("""
		Received XPC request.
		- Request: \(request)
		""")

		do {
			// Return an encodable response that will get sent back to the client.
			return try request.performTask()
		} catch {
			Self.logger.error("""
			Failed to process XPC request.
			- Request: \(request)
			- Error: \(error)
			""")
			return nil
		}
	}
}

// MARK: - Constants

private extension Client {
	static let logger = Logger(category: Self.self)
}
