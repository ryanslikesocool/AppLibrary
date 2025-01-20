import AppLibraryStorage
import AppLibraryRuntimeModel
import SwiftUI

extension ApplicationConfigurationSheet {
	struct Detail: View {
		private let applicationModelIdentifier: ApplicationModelIdentifier

		private var applicationModel: ApplicationModel? {
			@Application(applicationModelIdentifier) var applicationModel
			return $applicationModel
		}

		public init(for applicationModelIdentifier: ApplicationModelIdentifier) {
			self.applicationModelIdentifier = applicationModelIdentifier
		}

		public var body: some View {
			Form {
				ApplicationVisibilitySection(for: applicationModelIdentifier)
			}
			.formStyle(.grouped)
//			.navigationTitle(
//				applicationModel?.displayName ?? ""
//			)
		}
	}
}
