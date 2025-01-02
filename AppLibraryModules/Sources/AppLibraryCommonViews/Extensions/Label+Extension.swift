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
}
