import AppKit
import SwiftUI

final class BrowserViewController: NSViewController {
	override func loadView() {
		let background: NSView = {
			let view = NSVisualEffectView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.material = .popover
			view.state = .active
			view.wantsLayer = true
			view.layer?.cornerRadius = Self.cornerRadius
			view.layer?.cornerCurve = .continuous

			NSLayoutConstraint.activate([
				view.widthAnchor.constraint(equalToConstant: BrowserWindowController.windowSize.width),
				view.heightAnchor.constraint(equalToConstant: BrowserWindowController.windowSize.height),
			])

			return view
		}()
		
		let content: NSView = {
			let view = NSHostingView(rootView: ContentView())
			view.autoresizingMask = [.width, .height]

			return view
		}()

		background.addSubview(content)

		view = background
	}
}

// MARK: - Constants

extension BrowserViewController {
	static let cornerRadius: CGFloat = 16.0
}
