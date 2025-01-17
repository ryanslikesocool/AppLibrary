import AppKit
import AppLibraryAccessibilityHelperShared
import AppLibraryExtensionClient
import AppLibraryExtensionCommon
import CoreGraphics
import OSLog
import XPC

@main
public struct Client: AppLibraryXPCClientProtocol {
	typealias Message = AccessibilityHelperMessage

	public static var xpcServiceName: XPCServiceName { .accessibilityHelper }

	public var listener: XPCListener? = nil

	public init() {
		Self.logger.info("Initialized \(Self.self).")

		AccessibilityUtility.requestAccess()
	}

	public func handleSession(
		request: XPCListener.IncomingSessionRequest
	) -> XPCListener.IncomingSessionRequest.Decision {
		Self.logger.info("Received XPC request.")

		// When a session request arrives, you must either accept or reject it.
		// The listener invokes the closure you specify every time a
		// message is received.
		return request.accept(
			incomingMessageHandler: performTask(with:)
		)
	}

	// The function that performs the work of the service.
	func performTask(with request: Message.Request) -> (any Encodable)? {
		do {
			// Return an encodable response that will get sent back to the client.
			return try request.performTask()
		} catch {
			Self.logger.error("""
			Failed to decode received message.
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
