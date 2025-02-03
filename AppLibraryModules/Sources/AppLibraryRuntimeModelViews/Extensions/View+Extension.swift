import AppLibraryRuntimeModel
import SwiftData
import SwiftUI

public extension View {
	func applicationModelContainer() -> some View {
		modelContainer(ApplicationCache.shared.modelContainer)
	}
}