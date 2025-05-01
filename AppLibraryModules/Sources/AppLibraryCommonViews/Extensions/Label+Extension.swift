import SwiftUI

public extension Label where
	Title == Text,
	Icon == EmptyView
{
	/// Creates a label with a custom title.
	///
	/// - Parameter title:
	nonisolated init(
		@ViewBuilder title: () -> Title
	) {
		self.init(title: title, icon: EmptyView.init)
	}

	/// Creates a label with a title generated from a string.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameter title: A string used as the label’s title.
	nonisolated init<S>(
		_ title: S
	) where
		S: StringProtocol
	{
		self.init {
			Title(title)
		}
	}

	/// Creates a label with a title generated from a localized string.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameter titleKey: A title generated from a localized string.
	nonisolated init(
		_ titleKey: LocalizedStringKey
	) {
		self.init {
			Title(titleKey)
		}
	}

	/// Creates a label with a title generated from a string resource.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameter titleResource: A title generated from a string resource.
	// NOTE: This initializer is disfavored over the initializer that receives `LocalizedStringKey`.
	@_disfavoredOverload
	nonisolated init(
		_ titleResource: LocalizedStringResource
	) {
		self.init {
			Title(titleResource)
		}
	}
}
