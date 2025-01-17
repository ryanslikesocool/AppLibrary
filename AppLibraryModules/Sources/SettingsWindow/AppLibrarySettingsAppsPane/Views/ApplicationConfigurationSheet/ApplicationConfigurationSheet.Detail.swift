import AppLibraryStorage
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Detail: View {
		private let applicationModelIdentifier: ApplicationModelIdentifier

		public init(for applicationModelIdentifier: ApplicationModelIdentifier) {
			self.applicationModelIdentifier = applicationModelIdentifier
		}

		public var body: some View {
			ApplicationVisibilitySection(for: applicationModelIdentifier)
		}
	}
}
