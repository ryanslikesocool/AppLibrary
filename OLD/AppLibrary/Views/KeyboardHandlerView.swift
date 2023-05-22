import AppKit
import SwiftUI

struct KeyboardHandlerView: NSViewRepresentable {
	func makeNSView(context: Context) -> _InternalView {
		_InternalView(frame: .zero)
	}

	func updateNSView(_ nsView: _InternalView, context: Context) { }
}

extension KeyboardHandlerView {
	final class _InternalView: NSView {
		override var acceptsFirstResponder: Bool { true }

		override init(frame frameRect: NSRect) {
			super.init(frame: frameRect)
		}

		@available(*, unavailable)
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}

		override func keyDown(with event: NSEvent) {
			interpretKeyEvents([event])
		}

		override func insertText(_ insertString: Any) {
			NotificationCenter.default.post(name: .scrollJump, object: nil, userInfo: ["character": insertString])
		}

		override func insertTab(_ sender: Any?) {
			NotificationCenter.default.post(name: .activateSearch, object: nil)
		}
	}
}
