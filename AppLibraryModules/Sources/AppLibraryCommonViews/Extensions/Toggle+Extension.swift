import AppLibraryCommon
import SwiftUI

@MainActor
public extension Toggle {
	/// Creates a toggle that displays a custom label.
	///
	/// - Parameters:
	///   - selection:
	///   - element:
	///   - label: A view that describes the purpose of the toggle.
	init<Enum>(
		selection: Binding<some EnumOptionSet<Enum>>,
		element: Enum,
		@ViewBuilder label: () -> Label
	) where
		Enum: RawRepresentable,
		Enum.RawValue: FixedWidthInteger & UnsignedInteger
	{
		self.init(
			isOn: Binding(selection: selection, element: element),
			label: label
		)
	}
}

@MainActor
public extension Toggle where
	Label == Text
{
	/// Creates a toggle that generates its label from a string.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameters:
	///   - title: A string that describes the purpose of the toggle.
	///   - selection:
	///   - element:
	init<Enum, S>(
		_ title: S,
		selection: Binding<some EnumOptionSet<Enum>>,
		element: Enum
	) where
		S: StringProtocol,
		Enum: RawRepresentable,
		Enum.RawValue: FixedWidthInteger & UnsignedInteger
	{
		self.init(
			selection: selection,
			element: element
		) {
			Text(title)
		}
	}

	/// Creates a toggle that generates its label from a localized string key.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameters:
	///   - titleKey: The key for the toggle’s localized title, that describes the purpose of the toggle.
	///   - selection:
	///   - element:
	init<Enum>(
		_ titleKey: LocalizedStringKey,
		selection: Binding<some EnumOptionSet<Enum>>,
		element: Enum
	) where
		Enum: RawRepresentable,
		Enum.RawValue: FixedWidthInteger & UnsignedInteger
	{
		self.init(
			selection: selection,
			element: element
		) {
			Text(titleKey)
		}
	}

	/// Creates a toggle that generates its label from a string resource.
	///
	/// This initializer creates a
	/// [`Text`]( https://developer.apple.com/documentation/swiftui/text )
	/// view on your behalf.
	///
	/// - Parameters:
	///   - titleResource: A string resource that describes the purpose of the toggle.
	///   - selection:
	///   - element:
	// NOTE: This initializer is disfavored over the initializer that receives `LocalizedStringKey`.
	@_disfavoredOverload
	init<Enum>(
		_ titleResource: LocalizedStringResource,
		selection: Binding<some EnumOptionSet<Enum>>,
		element: Enum
	) where
		Enum: RawRepresentable,
		Enum.RawValue: FixedWidthInteger & UnsignedInteger
	{
		self.init(
			selection: selection,
			element: element
		) {
			Text(titleResource)
		}
	}
}
