import AppLibraryCommonViews
import AppLibraryRuntimeModel
import AppLibraryRuntimeModelViews
import AppLibraryStorage
import SwiftData
import SwiftUI

extension ApplicationConfigurationSheet.Sidebar {
	struct ContextMenu: View {
		private let applicationModel: ApplicationModel

		public init?(
			for selections: Set<ApplicationModel.ID>,
			in modelContext: ModelContext
		) {
			guard
				selections.count == 1,
				let selection = selections.first,
				let applicationModel: ApplicationModel = modelContext.registeredModel(for: selection)
			else {
				return nil
			}

			self.applicationModel = applicationModel
		}

		public var body: some View {
			ShowInFinderButton(latestInstance: applicationModel)
		}
	}
}
