import AppKit
import AppLibraryCommon
import AppLibraryDockHelperShared
import AppLibraryExtensionCommon
import AppLibraryExtensionServer
import CoreGraphics
import Foundation
import OSLog
import XPC

@MainActor
public final class DockHelperServer: AppLibraryXPCServer {
	override public class var serviceName: XPCServiceName { .dockHelper }

	public func requestDockTileRect(
		for bundle: Bundle = .main
	) throws -> CGRect {
		Self.logger.debug("""
		Starting XPC request.
		- Function: \(#function)
		""")

		let request = DockHelperMessage.Request.dockTileRect(bundleURL: bundle.bundleURL)
		let response: DockHelperMessage.Response = try session.sendSync(request)

		guard case let .dockTileRect(response) = response else {
			throw XPCFailure.invalidResponse
		}
		return response.rect
	}

	public func requestEstimatedEdge(
		screenIndex: Int
	) throws -> DockEdge {
		Self.logger.debug("""
		Starting XPC request.
		- Function: \(#function)
		""")

		let request = DockHelperMessage.Request.dockEstimatedEdge(screenIndex: screenIndex)
		let response: DockHelperMessage.Response = try session.sendSync(request)

		guard case let .dockEstimatedEdge(response) = response else {
			throw XPCFailure.invalidResponse
		}
		return response.edge
	}

	public func requestEstimatedEdge(
		screen: NSScreen? = .main
	) throws -> DockEdge {
		guard let screenIndex = NSScreen.index(of: screen) else {
			throw XPCFailure.requestFailed
		}

		return try requestEstimatedEdge(screenIndex: screenIndex)
	}

	public func requestRectAndEstimatedEdge(
		screenIndex: Int
	) throws -> (rect: CGRect, edge: DockEdge) {
		Self.logger.debug("""
		Starting XPC request.
		- Function: \(#function)
		""")

		let request = DockHelperMessage.Request.dockRectAndEstimatedEdge(screenIndex: screenIndex)
		let response: DockHelperMessage.Response = try session.sendSync(request)

		guard case let .dockRectAndEstimatedEdge(response) = response else {
			throw XPCFailure.invalidResponse
		}
		return (response.rect, response.edge)
	}

	public func requestRectAndEstimatedEdge(
		screen: NSScreen? = .main
	) throws -> (rect: CGRect, edge: DockEdge) {
		guard let screenIndex = NSScreen.index(of: screen) else {
			throw XPCFailure.requestFailed
		}

		return try requestRectAndEstimatedEdge(screenIndex: screenIndex)
	}
}

// MARK: - Constants

public extension DockHelperServer {
	static let shared: DockHelperServer = try! DockHelperServer()

	private nonisolated static let logger: Logger = Logger(category: DockHelperServer.self)
}
