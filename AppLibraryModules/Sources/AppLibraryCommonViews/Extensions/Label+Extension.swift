import SwiftUI

public extension Label where
	Title == Text,
	Icon == Image
{
	nonisolated init(_ title: LocalizedStringResource, systemImage name: String) {
		self.init(String(localized: title), systemImage: name)
	}

	nonisolated init(_ title: LocalizedStringResource, image name: String) {
		self.init(String(localized: title), image: name)
	}

	nonisolated init<S>(_ title: S, systemImage name: SFSymbol) where
		S: StringProtocol
	{
		self.init(title, systemImage: name.rawValue)
	}

	nonisolated init(_ title: LocalizedStringResource, systemImage name: SFSymbol) {
		self.init(title, systemImage: name.rawValue)
	}

	nonisolated init(_ titleKey: LocalizedStringKey, systemImage name: SFSymbol) {
		self.init(titleKey, systemImage: name.rawValue)
	}

	nonisolated init<S>(_ title: S, image name: CustomSFSymbol) where
		S: StringProtocol
	{
		self.init(title, image: name.rawValue)
	}

	nonisolated init(_ title: LocalizedStringResource, image name: CustomSFSymbol) {
		self.init(title, systemImage: name.rawValue)
	}

	nonisolated init(_ titleKey: LocalizedStringKey, image name: CustomSFSymbol) {
		self.init(titleKey, systemImage: name.rawValue)
	}
}
