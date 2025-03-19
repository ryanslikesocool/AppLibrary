import SwiftUI

extension EnvironmentValues {
	@Entry
	fileprivate(set) var descriptiveLabelElementVisibility: DescriptiveLabelElementVisibility = .all
}

// MARK: - Convenience

public extension View {
	nonisolated func descriptiveLabelElementVisibility(
		_ elementVisibility: DescriptiveLabelElementVisibility
	) -> some View {
		environment(\.descriptiveLabelElementVisibility, elementVisibility)
	}
}
