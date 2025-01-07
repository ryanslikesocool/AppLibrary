import AppKit
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public struct ApplicationIcon: View {
	private let image: Image

	private init(image: Image) {
		self.image = image
	}

	private init(nsImage: NSImage) {
		self.init(image: Image(nsImage: nsImage))
	}

	public var body: some View {
		image
			.resizable()
			.aspectRatio(contentMode: .fit)
	}
}

// MARK: - Convenience

public extension ApplicationIcon {
	init(for applicationModelIdentifier: ApplicationModelIdentifier) {
		@Application(applicationModelIdentifier) var application
		self.init(for: $application)
	}

	init(for applicationModel: ApplicationModel) {
		self.init(nsImage: applicationModel.getLatestIcon())
	}

	@_disfavoredOverload
	init(for applicationModel: ApplicationModel?) {
		self.init(nsImage: applicationModel.getLatestIcon())
	}
}
