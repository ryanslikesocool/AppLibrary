import AppLibraryCommon
import SwiftUI

// public extension Binding {
//	@MainActor
//	subscript<Enum>(
//		element: Enum
//	) -> Binding<Bool> where
//		Value == EnumOptionSet<Enum>,
//		Enum: RawRepresentable,
//		Enum.RawValue: FixedWidthInteger & UnsignedInteger
//	{
//		Binding<Bool>(
//			get: { self.wrappedValue[element] },
//			set: { newValue in self.wrappedValue[element] = newValue }
//		)
//	}
// }

public extension Binding<Bool> {
 	@MainActor
	init<Enum>(
		selection: Binding<some EnumOptionSet<Enum>>,
		element: Enum
	) where
		Enum: RawRepresentable,
		Enum.RawValue: FixedWidthInteger & UnsignedInteger
	{
		self.init(
			get: { selection.wrappedValue[element] },
			set: { newValue in selection.wrappedValue[element] = newValue }
		)
	}
}
