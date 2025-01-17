import AppKit
import AppLibraryAccessibilityHelperShared
import AppLibraryCommon
import AppLibraryExtensionCommon
import AppLibraryExtensionServer
import OSLog

public extension AccessibilityHelperServer {
	// MARK: requestDockTileRect

	func requestDockTileRect(
		for bundle: Bundle = .main
	) throws -> CGRect {
		typealias Message = DockTileRectMessage

		Self.logger.debug("""
		\(StaticString.startXPCRequestPrefix)
		- Function: \(#function)
		""")

		let request = Message.Request(bundleURL: bundle.bundleURL)
		let response: Message.Response = try session.sendSync(request: request)

		return response.rect
	}

	// MARK: requestEstimatedEdge

	func requestEstimatedEdge(
		screenIndex: Int
	) throws -> DockEdge {
		typealias Message = DockEstimatedEdgeMessage

		Self.logger.debug("""
		\(StaticString.startXPCRequestPrefix)
		- Function: \(#function)
		""")

		let request = Message.Request(screenIndex: screenIndex)
		let response: Message.Response = try session.sendSync(request: request)

		return response.edge
	}

	func requestEstimatedEdge(
		screen: NSScreen? = .main
	) throws -> DockEdge {
		guard let screenIndex = NSScreen.index(of: screen) else {
			throw XPCFailure.requestFailed
		}

		return try requestEstimatedEdge(screenIndex: screenIndex)
	}

	// MARK: requestRectAndEstimatedEdge

	func requestRectAndEstimatedEdge(
		screenIndex: Int
	) throws -> (rect: CGRect, edge: DockEdge) {
		typealias Message = DockRectAndEstimatedEdgeMessage

		Self.logger.debug("""
		\(StaticString.startXPCRequestPrefix)
		- Function: \(#function)
		""")

		let request = Message.Request(screenIndex: screenIndex)
		let response: Message.Response = try session.sendSync(request: request)

		return (response.rect, response.edge)
	}

	func requestRectAndEstimatedEdge(
		screen: NSScreen? = .main
	) throws -> (rect: CGRect, edge: DockEdge) {
		guard let screenIndex = NSScreen.index(of: screen) else {
			throw XPCFailure.requestFailed
		}

		return try requestRectAndEstimatedEdge(screenIndex: screenIndex)
	}

	// MARK: requestAccessibilityAccess

	@discardableResult
	func requestAccessibilityAccess() throws -> Bool {
		typealias Message = RequestAccessibilityAccessMessage

		Self.logger.debug("""
		\(StaticString.startXPCRequestPrefix)
		- Function: \(#function)
		""")

		let request = Message.Request()
		let response: Message.Response = try session.sendSync(request: request)

		return response.success
	}
}
