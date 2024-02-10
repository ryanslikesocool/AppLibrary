import SwiftUI

extension View {
	func wrap(@ViewBuilder content: @escaping (Self) -> some View) -> some View {
		content(self)
	}
}
