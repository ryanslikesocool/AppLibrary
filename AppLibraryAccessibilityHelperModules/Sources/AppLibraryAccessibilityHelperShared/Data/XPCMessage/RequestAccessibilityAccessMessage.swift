import AppLibraryExtensionCommon

public struct RequestAccessibilityAccessMessage: XPCMessage {
	public typealias Super = AccessibilityHelperMessage
	public typealias Failure = Super.Failure

	public init() { }
}

// MARK: - Request

public extension RequestAccessibilityAccessMessage {
	struct Request: XPCMessageRequest {
		public typealias Message = RequestAccessibilityAccessMessage

		public init() { }
	}
}

// MARK: - Response

public extension RequestAccessibilityAccessMessage {
	struct Response: XPCMessageResponse {
		public typealias Message = RequestAccessibilityAccessMessage
		public typealias Result = Swift.Result<Self, Failure>

		/// A Boolean value indicating if the request was successful or not.
		public let success: Bool

		/// - Parameters:
		///   - success: `true` if the request was successful; `false` otherwise.
		public init(success: Bool) {
			self.success = success
		}
	}
}
