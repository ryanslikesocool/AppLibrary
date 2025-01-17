import AppLibraryExtensionCommon
import XPC

open class AppLibraryXPCServer: AppLibraryXPCServerProtocol {
	private var _session: XPCSession!
	public var session: XPCSession { _session }

	open class var serviceName: XPCServiceName {
		fatalError("Subclasses of `AppLibraryXPCServer` must override `serviceName`.")
	}

	public init() throws {
		_session = try XPCSession(
			xpcService: Self.serviceName,
			targetQueue: Self.targetQueue,
			options: Self.options,
			cancellationHandler: cancelled(with:)
		)
	}

//	deinit {
//		session.cancel(reason: "Server deinitialized")
//	}

//	open func cancelled(with error: XPCRichError) { }

//	open consuming func complete() {
//		session.cancel(reason: "Session complete")
//	}
}
