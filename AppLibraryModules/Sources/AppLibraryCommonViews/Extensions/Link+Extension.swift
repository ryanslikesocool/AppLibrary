import SFSymbolToolbox
import SwiftUI

public extension Link where
	Label == SwiftUI.Label<Text, Image>
{
	init<S>(
		_ title: S,
		systemImage: String,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(destination: destination) {
			Label(title, systemImage: systemImage)
		}
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage: String,
		destination: URL
	) {
		self.init(destination: destination) {
			Label(titleKey, systemImage: systemImage)
		}
	}

	init<S>(
		_ title: S,
		systemImage: SystemSymbolName,
		destination: URL
	) where
		S: StringProtocol
	{
		self.init(title, systemImage: systemImage.rawValue, destination: destination)
	}

	init(
		_ titleKey: LocalizedStringKey,
		systemImage: SystemSymbolName,
		destination: URL
	) {
		self.init(titleKey, systemImage: systemImage.rawValue, destination: destination)
	}

	// MARK: init(destination: URL?)

	init?<S>(
		_ title: @autoclosure () -> S,
		systemImage: @autoclosure () -> String,
		destination: URL?
	) where
		S: StringProtocol
	{
		guard let destination else {
			return nil
		}
		self.init(title(), systemImage: systemImage(), destination: destination)
	}

	init?(
		_ titleKey: @autoclosure () -> LocalizedStringKey,
		systemImage: @autoclosure () -> String,
		destination: URL?
	) {
		guard let destination else {
			return nil
		}
		self.init(titleKey(), systemImage: systemImage(), destination: destination)
	}

	init?<S>(
		_ title: @autoclosure () -> S,
		systemImage: @autoclosure () -> SystemSymbolName,
		destination: URL?
	) where
		S: StringProtocol
	{
		guard let destination else {
			return nil
		}
		self.init(title(), systemImage: systemImage().rawValue, destination: destination)
	}

	init?(
		_ titleKey: @autoclosure () -> LocalizedStringKey,
		systemImage: @autoclosure () -> SystemSymbolName,
		destination: URL?
	) {
		guard let destination else {
			return nil
		}
		self.init(titleKey(), systemImage: systemImage().rawValue, destination: destination)
	}
}
