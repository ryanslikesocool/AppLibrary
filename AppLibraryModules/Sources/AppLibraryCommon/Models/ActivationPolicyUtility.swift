import AppKit
import Combine
import AppLibraryCore
import OSLog

@MainActor
public enum ActivationPolicyUtility {
	/// The current activation policy for the application.
	static var current: NSApplication.ActivationPolicy {
		get { NSApp.activationPolicy() }
		set {
			let success = NSApp.setActivationPolicy(newValue)

			logger.log(
				level: success ? .debug : .error,
				"""
				\(success ? "Successfully" : "Failed to") set activation policy.
				- Old Value: \(String(describing: current))
				- New Value: \(String(describing: newValue))
				"""
			)
		}
	}

	/// The target activation policy for the application policy, computed based on which windows are visible.
	static var target: NSApplication.ActivationPolicy {
		let intersection = Set(NSApp.windows
			.filter(\.isVisible)
			.compactMap { window -> WindowIdentifier? in
				guard let windowIdentifier = window.identifier else {
					return nil
				}
				return WindowIdentifier(windowIdentifier)
			})
			.intersection([.about, .settings])

		return if intersection.isEmpty {
			// `.browser`
			.accessory
		} else {
			// `.about`, `.settings`
			.regular
		}
	}
}

// MARK: - Constants

private extension ActivationPolicyUtility {
	static let logger: Logger = Logger(category: Self.self)
}
