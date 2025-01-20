import AppLibraryExtensionCommon

public protocol AccessibilityHelperMessageProtocol: XPCMessage where
	Failure == AccessibilityHelperMessage.Failure,
	Output == Swift.Result<Response, Failure>
{
	typealias Super = AccessibilityHelperMessage
}