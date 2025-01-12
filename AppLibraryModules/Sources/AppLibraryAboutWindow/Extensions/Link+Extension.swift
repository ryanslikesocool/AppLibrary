import SwiftUI
import AppLibraryCommonViews

extension Link {
	init<Icon>(
		_ title: String,
		icon: Icon,
		destination: URL
	) where
		Icon: View,
		Label == SwiftUI.Label<Text, Icon>
	{
		self.init(destination: destination) {
			Label {
				Text(verbatim: title)
			} icon: {
				icon
			}
		}
	}

	init?<Icon>(
		_ title: @autoclosure () -> String,
		icon: @autoclosure () -> Icon,
		destination: URL?
	) where
		Icon: View,
		Label == SwiftUI.Label<Text, Icon>
	{
		guard let destination else {
			return nil
		}
		self.init(title(), icon: icon(), destination: destination)
	}
}
