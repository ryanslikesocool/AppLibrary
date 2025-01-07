import AppLibraryCommon
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

public struct ApplicationLabel: View {
	public typealias StyleConfiguration = ApplicationLabelStyleConfiguration

	@Environment(\.applicationLabelStyle) private var style

	private let title: Text
	private let icon: ApplicationIcon

	public init(for applicationModel: ApplicationModel) {
		title = Text(verbatim: applicationModel.displayName)
		icon = ApplicationIcon(for: applicationModel)
	}

	public var body: some View {
		let configuration = StyleConfiguration(
			title: title,
			icon: icon
		)

		style.makeBody(configuration: configuration)
	}
}

// MARK: - Convenience

public extension ApplicationLabel {
	init?(for applicationModelIdentifier: ApplicationModelIdentifier) {
		@Application(applicationModelIdentifier) var application
		guard let applicationModel = $application else {
			return nil
		}

		self.init(for: applicationModel)
	}
}
