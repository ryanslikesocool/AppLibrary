import AppLibraryCommonViews
import AppLibraryStorage
import SwiftUI

@MainActor
public extension Toggle where
	Label == Text
{
	init(
		selection: Binding<ApplicationVisibility.Set>,
		element: ApplicationVisibility
	) {
		self.init(
			LocalizedStringResource.applicationVisibilityPicker.item.format.adjective(element.localizedStringResource),
			selection: selection,
			element: element
		)
	}
}
