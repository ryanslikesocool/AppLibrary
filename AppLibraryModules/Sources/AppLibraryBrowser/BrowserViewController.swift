import AppKit
import AppLibraryStorage
import Combine
import OSLog
import SwiftUI

final class BrowserViewController: NSViewController {
	private var receiveReduceTransparencyChangedSubscriber: AnyCancellable?

	override func loadView() {
		let background: NSView = {
			let view = NSVisualEffectView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.material = .windowBackground
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

		Logger.module.debug("Finished executing \(#function).")
	}
	
	override func viewDidLoad() {
		receiveReduceTransparencyChangedSubscriber = AppSettings.shared.$display
			.sink { [weak self] display in
				let material = Self.getBackgroundMaterial(for: display.reduceTransparency)
				self?.setBackgroundMaterial(to: material)
			}
	}

	override func performKeyEquivalent(with event: NSEvent) -> Bool {
		switch event.charactersIgnoringModifiers {
			case "f":
				BrowserCache.shared.isSearchFocused = true
				Logger.module.debug("Activate search.")
				return true
			default:
				return super.performKeyEquivalent(with: event)
		}
	}
}

// MARK: - Constants

extension BrowserViewController {
	static let cornerRadius: CGFloat = 16.0
}

// MARK: -

private extension BrowserViewController {
	func setBackgroundMaterial(to material: NSVisualEffectView.Material) {
		guard let visualEffectView = view as? NSVisualEffectView else {
			Logger.module.warning("\(Self.self)'s `view` was not of the type \(NSVisualEffectView.self).  This should not happen.")
			return
		}
		visualEffectView.material = material
		Logger.module.debug("Changed browser background material.")
	}

	static func getBackgroundMaterial(for reduceTransparencySetting: Bool) -> NSVisualEffectView.Material {
		reduceTransparencySetting ? .windowBackground : .underWindowBackground
	}
}
