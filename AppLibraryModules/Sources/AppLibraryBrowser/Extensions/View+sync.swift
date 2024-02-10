import SwiftUI

extension View {
	func sync<T: Equatable>(_ binding: Binding<T>, with focusState: FocusState<T>) -> some View {
		onChange(of: binding.wrappedValue) {
			focusState.wrappedValue = $0
		}
		.onChange(of: focusState.wrappedValue) {
			binding.wrappedValue = $0
		}
	}
}
