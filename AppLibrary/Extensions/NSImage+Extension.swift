import Cocoa

extension NSImage {
	static func loadRepresentation(for source: NSImage?, size: CGSize) -> NSImage? {
		guard
			let representation = source?.bestRepresentation(for: CGRect(origin: .zero, size: size), context: nil, hints: nil)
		else {
			return nil
		}

		let image = NSImage(size: size)
		image.addRepresentation(representation)
		return image
	}
}
