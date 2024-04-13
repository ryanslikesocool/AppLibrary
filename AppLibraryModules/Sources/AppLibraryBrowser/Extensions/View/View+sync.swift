import SwiftUI

extension View {
	func sync<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
		onChange(of: binding.wrappedValue) {
			focusState.wrappedValue = binding.wrappedValue
		}
		.onChange(of: focusState.wrappedValue) {
			binding.wrappedValue = focusState.wrappedValue
		}
	}
}
