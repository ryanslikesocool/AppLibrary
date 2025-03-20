import SwiftUI

public extension EnvironmentValues {
	@Entry
	fileprivate(set) var delete: DeleteAction? = nil
}

// MARK: - Convenience

public extension View {
	nonisolated func deleteAction(
		_ action: (() -> Void)?
	) -> some View {
		environment(\.delete, DeleteAction(action))
	}
}
