import Cocoa
import SwiftUI
import UniformTypeIdentifiers

private extension NSWindow {
	private static let animationDuration: Double = 0.2

	private func animate(opacity: Double, onComplete: (() -> Void)?) {
		NSAnimationContext.runAnimationGroup({ context in
			context.duration = Self.animationDuration
			animator().alphaValue = opacity
		}, completionHandler: onComplete)
	}

	private func saveSnapshot() {
		guard
			let cgImage: CGImage = makeSnapshot(),
			let dest = CGImageDestinationCreateWithURL(URL.desktopDirectory.appending(component: "snapshot.png") as CFURL, UTType.png.identifier as CFString, 1, nil)
		else {
			return
		}

		CGImageDestinationAddImage(dest, cgImage, nil)
		CGImageDestinationFinalize(dest)
	}

	private func makeSnapshot() -> CGImage? {
		guard contentView != nil else {
			return nil
		}

		let rect: CGRect = CGRect(x: Double.infinity, y: Double.infinity, width: 0, height: 0)

		return CGWindowListCreateImage(rect, .optionIncludingWindow, CGWindowID(windowNumber), .bestResolution)
	}

	private func makeSnapshot() -> NSImage? {
		guard let cgImage: CGImage = makeSnapshot() else {
			return nil
		}

		return NSImage(cgImage: cgImage, size: CGSize(width: cgImage.width, height: cgImage.height))
	}
}
