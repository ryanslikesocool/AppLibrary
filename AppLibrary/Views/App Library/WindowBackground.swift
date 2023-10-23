import SwiftUI
import AppKit

struct WindowBackground: NSViewControllerRepresentable {
	func makeNSViewController(context: Context) -> ViewController {
		ViewController()
	}

	func updateNSViewController(_ nsViewController: ViewController, context: Context) {}
}

extension WindowBackground {
	final class ViewController: NSViewController {

		override func loadView() {
			let background = NSVisualEffectView()


			self.view = background
		}

		override func viewDidAppear() {
			guard let window = view.window else {
				return
			}
		}
	}
}
