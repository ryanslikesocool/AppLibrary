import AppKit
import AppLibraryAccessibilityHelperCommon
import AppLibraryCore
import AppLibraryExtensionCommon
import AppLibraryExtensionServer
import OSLog

public extension AccessibilityHelperServer {
	// MARK: requestDockTileRect

	func requestDockTileRect(
		for bundle: Bundle = .main
	) throws -> CGRect {
		Self.logStartXPCRequest()

		let request = Message.Request.dockTileRect(bundleURL: bundle.bundleURL)
		let response: Message.Response = try session.sendSync(request)

		guard case let .dockTileRect(result) = response else {
			throw XPCFailure.invalidResponse
		}
		let responseValue = try result.get()

		return responseValue.rect
	}

	// MARK: requestEstimatedEdge

	func requestEstimatedEdge(
		screenIndex: Int
	) throws -> DockEdge {
		typealias Message = AccessibilityHelperMessage

		Self.logStartXPCRequest()

		let request = Message.Request.dockEstimatedEdge(screenIndex: screenIndex)
		let response: Message.Response = try session.sendSync(request)

		guard case let .dockEstimatedEdge(result) = response else {
			throw XPCFailure.invalidResponse
		}
		let responseValue = try result.get()

		return responseValue.edge
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
		Self.logStartXPCRequest()

		let request = Message.Request.dockRectAndEstimatedEdge(screenIndex: screenIndex)
		let response: Message.Response = try session.sendSync(request)

		guard case let .dockRectAndEstimatedEdge(result) = response else {
			throw XPCFailure.invalidResponse
		}
		let responseValue = try result.get()

		return (responseValue.rect, responseValue.edge)
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
		Self.logStartXPCRequest()

		let request = Message.Request.requestAccessibilityAccess()
		let response: Message.Response = try session.sendSync(request)

		guard case let .requestAccessibilityAccess(result) = response else {
			throw XPCFailure.invalidResponse
		}
		let responseValue = try result.get()

		return responseValue.success
	}
}

// MARK: - Logging

private extension AccessibilityHelperServer {
	@_transparent // `@_transparent` to inline function content
	static func logStartXPCRequest(
		_ function: StaticString = #function,
	) {
#if DEBUG
		if FeatureFlag.Log.startXPCRequest {
			logger.debug("""
			\(StaticString.startXPCRequestPrefix)
			- Function: \(function)
			""")
		}
#endif
	}
}
