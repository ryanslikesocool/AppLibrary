import AppKit
import AppLibraryRuntimeModel
import AppLibraryStorage
import PainlessCG
import SwiftUI

public struct ApplicationIcon: View {
	/// The image to display.
	private let image: Image

	/// The minimum number of times to stack the ``image``.
	private let stackCount: Int

	/// - Parameters:
	///   - image: The image to display.
	///   - stackCount: The number of times to stack the `image`.
	private init(
		image: Image,
		stackCount: Int
	) {
		self.stackCount = stackCount.clamped(to: Self.stackCountRange)
		self.image = image
	}

	public var body: some View {
//		if stackCount > 1 {
		icon
			.background {
				ForEach(
					(1 ... stackCount).dropFirst().reversed(),
					id: \.self,
					content: stackIcon(index:)
				)
			}
//		} else {
//			icon
//		}
	}
}

// MARK: - Constants

private extension ApplicationIcon {
	static let stackCountRange: ClosedRange<Int> = 1 ... 3

	static let stackInstanceOffset: CGSize = CGSize(width: 0, height: 6)

	static let stackInstanceSizeDelta: CGFloat = 4

	static let stackInstanceWhiteStep: Double = 0.1
}

// MARK: - Supporting Views

private extension ApplicationIcon {
	var icon: some View {
		image
			.resizable()
			.aspectRatio(contentMode: .fit)
	}

	func stackIcon(index: Int) -> some View {
		let scale = CGFloat(index - 1)

		return icon
			.colorMultiply(
				Color(white: 1 - Self.stackInstanceWhiteStep * scale)
			)

			.padding(.horizontal, Self.stackInstanceSizeDelta * scale)
			.offset(Self.stackInstanceOffset * scale)
	}
}

// MARK: - Convenience

private extension ApplicationIcon {
	/// - Parameters:
	///   - nsImage: The image to display.
	///   - stackCount: The number of times to stack the `image`.
	init(
		nsImage: NSImage,
		stackCount: Int
	) {
		self.init(
			image: Image(nsImage: nsImage),
			stackCount: stackCount
		)
	}
}

public extension ApplicationIcon {
	/// - Parameters:
	///   - applicationModelIdentifier:
	///   - stackCount: The number of times to stack the image.
	///   Set this to `nil` to use the number of ``ApplicationModel/instances`` for the `applicationModelIdentifier`.
	init(
		for applicationModelIdentifier: ApplicationModelIdentifier,
		stackCount: Int? = nil
	) {
		@Application(applicationModelIdentifier) var application
		self.init(for: $application, stackCount: stackCount)
	}

	/// - Parameters:
	///   - applicationModel:
	///   - stackCount: The number of times to stack the image.
	///   Set this to `nil` to use the number of ``ApplicationModel/instances`` for the `applicationModel`.
	init(
		for applicationModel: ApplicationModel,
		stackCount: Int? = nil
	) {
		self.init(
			nsImage: applicationModel.getLatestIcon(),
			stackCount: stackCount ?? applicationModel.instances.count
		)
	}

	/// - Parameters:
	///   - applicationModel:
	///   - stackCount: The number of times to stack the image.
	///   Set this to `nil` to use the number of ``ApplicationModel/instances`` for the `applicationModel`.
	@_disfavoredOverload
	init(
		for applicationModel: ApplicationModel?,
		stackCount: Int? = nil
	) {
		self.init(
			nsImage: applicationModel.getLatestIcon(),
			stackCount: stackCount ?? applicationModel?.instances.count ?? Self.stackCountRange.lowerBound
		)
	}
}
