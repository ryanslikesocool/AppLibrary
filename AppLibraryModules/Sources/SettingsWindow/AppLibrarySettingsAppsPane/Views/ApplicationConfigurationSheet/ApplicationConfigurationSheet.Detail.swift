import AppLibraryRuntimeModel
import AppLibraryStorage
import AppLibraryStorageViews
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
				ApplicationVisibilityPicker<TupleView<(Text, Text)>>(for: applicationModelIdentifier)
			}
			.formStyle(.grouped)
//			.navigationTitle(
//				applicationModel?.displayName ?? ""
//			)
		}
	}
}
