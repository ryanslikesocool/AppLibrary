import AppLibraryCommon
import SwiftUI

public extension Window {
	/// Creates a window with a title and an identifier.
	///
	/// The window displays the view that you specify.
	///
	/// - Remark: This initializer automatically assigns the ``SwiftUICore/EnvironmentValues/windowID`` environment key.
	///
	/// - Important: The system ignores any text styling that you apply to the
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view `title`, like bold or italics.
	/// However, you can use the formatting controls that the view offers, like for localization, dates, and numerical representations.
	///
	/// - Parameters:
	///   - title: The
	///   [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	///   view to use for the window’s title in system menus and in the window’s title bar. Provide a title that describes the purpose of the window.
	///   - id: A unique ``WindowIdentifier`` that you can use to open the window.
	///   - content: The view content to display in the window.
	init<C>(
		_ title: Text,
		id: borrowing WindowIdentifier,
		@ViewBuilder content: () -> C
	) where
		C: View,
		Content == ModifiedContent<C, _WindowIDViewModifier>
	{
		self.init(title, id: id.rawValue) {
			content()
				._windowID(id)
		}
	}

	/// Creates a window with a title string and an identifier.
	///
	/// The window displays the view that you specify.
	///
	/// - Remark: This initializer automatically assigns the ``SwiftUICore/EnvironmentValues/windowID`` environment key.
	///
	/// - Parameters:
	///   - title: A string to use for the window’s title in system menus and in the window’s title bar. Provide a title that describes the purpose of the window.
	///   - id: A unique ``WindowIdentifier`` that you can use to open the window.
	///   - content: The view content to display in the window.
	init<S, C>(
		_ title: S,
		id: borrowing WindowIdentifier,
		@ViewBuilder content: () -> C
	) where
		S: StringProtocol,
		C: View,
		Content == ModifiedContent<C, _WindowIDViewModifier>
	{
		self.init(title, id: id.rawValue) {
			content()
				._windowID(id)
		}
	}

	/// Creates a window with a title string and an identifier.
	///
	/// The window displays the view that you specify.
	///
	/// - Remark: This initializer automatically assigns the ``SwiftUICore/EnvironmentValues/windowID`` environment key.
	///
	/// - Parameters:
	///   - titleKey: A localized string key to use for the window’s title in system menus and in the window’s title bar. Provide a title that describes the purpose of the window.
	///   - id: A unique ``WindowIdentifier`` that you can use to open the window.
	///   - content: The view content to display in the window.
	init<C>(
		_ titleKey: LocalizedStringKey,
		id: borrowing WindowIdentifier,
		@ViewBuilder content: () -> C
	) where
		C: View,
		Content == ModifiedContent<C, _WindowIDViewModifier>

	{
		self.init(titleKey, id: id.rawValue) {
			content()
				._windowID(id)
		}
	}
}
