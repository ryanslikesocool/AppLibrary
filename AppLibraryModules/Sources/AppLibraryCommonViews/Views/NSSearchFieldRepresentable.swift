import AppKit
import SwiftUI

public struct NSSearchFieldRepresentable: NSViewRepresentable {
	@Binding private var string: String

	public init(string: Binding<String>) {
		_string = string
	}

	public func makeNSView(context: Context) -> NSSearchField {
		let nsView = NSSearchField()

		nsView.delegate = context.coordinator

		context.coordinator.withUpdateLock {
			nsView.stringValue = self.string
		}

		return nsView
	}

	public func updateNSView(_ nsView: NSSearchField, context: Context) {
		context.coordinator.parent = self

		do {
			context.coordinator.withUpdateLock {
				if context.coordinator.didChangeString == false {
					nsView.stringValue = self.string
				}
			}
			context.coordinator.didChangeString = false
		}

		if context.coordinator.previousFont != context.environment.font {
			nsView.font = NSFont.preferredFont(for: context.environment.font)
			context.coordinator.previousFont = context.environment.font
		}
		context.environment.apply(to: nsView)

		nsView.needsLayout = true
		nsView.needsDisplay = true
	}

	public func makeCoordinator() -> Coordinator {
		Coordinator(parent: self)
	}

//	public static func dismantleNSView(_ nsView: NSSearchField, coordinator: Coordinator) {	}
}

// MARK: - Coordinator

public extension NSSearchFieldRepresentable {
	final class Coordinator: NSObject {
		fileprivate var parent: NSSearchFieldRepresentable

		fileprivate private(set) var isUpdating: Bool = false
		fileprivate var didChangeString: Bool = false

		fileprivate var previousFont: Font? = nil

		fileprivate init(parent: NSSearchFieldRepresentable) {
			self.parent = parent

			isUpdating = false
			didChangeString = false

			previousFont = nil

			super.init()
		}

		fileprivate func withUpdateLock<Result>(
			body: () throws -> Result
		) rethrows -> Result {
			isUpdating = true
			defer { isUpdating = false }

			return try body()
		}
	}
}

extension NSSearchFieldRepresentable.Coordinator: NSSearchFieldDelegate {
	public func controlTextDidChange(_ notification: Notification) {
		guard let nsView = notification.object as? NSSearchFieldRepresentable.NSViewType else {
			return
		}

		if !isUpdating {
			let newStringValue = nsView.stringValue

			Task { @MainActor in
				self.didChangeString = true
				self.parent.string = newStringValue
			}
		}
	}
}
