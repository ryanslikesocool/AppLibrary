import SwiftUI

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

	init(
		_ title: String,
		systemImage: String,
		destination: URL
	) where
		Label == SwiftUI.Label<Text, Image>
	{
		self.init(
			title,
			icon: Image(systemName: systemImage),
			destination: destination
		)
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
		self.init(
			title(),
			icon: icon(),
			destination: destination
		)
	}

	init?(
		_ title: @autoclosure () -> String,
		systemImage: @autoclosure () -> String,
		destination: URL?
	) where
		Label == SwiftUI.Label<Text, Image>
	{
		self.init(
			title(),
			icon: Image(systemName: systemImage()),
			destination: destination
		)
	}
}