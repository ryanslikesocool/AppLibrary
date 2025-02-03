import OSLog
import AppLibraryRuntimeModel
import AppLibraryStorage
import SwiftUI

struct ApplicationIterator: View {
	@FocusState.Binding private var focusState: BrowserFocusElement?

	private let applications: [ApplicationModel]

	public init(
		applications: [ApplicationModel],
		focusState: FocusState<BrowserFocusElement?>.Binding
	) {
		self.applications = applications
		_focusState = focusState
	}

	public var body: some View {
		ForEach(applications) { application in
			ApplicationTile(for: application, focusState: $focusState)
		}
	}
}

// MARK: - Convenience

extension ApplicationIterator {
	init(
		applications: some Sequence<ApplicationModel>,
		focusState: FocusState<BrowserFocusElement?>.Binding
	) {
		self.init(
			applications: Array(applications),
			focusState: focusState
		)
	}
}

// MARK: -

extension ApplicationIterator {
	@ViewBuilder
	func grouped(_ state: Bool = true) -> some View {
		if state {
			ApplicationIterator.Grouped(
				applications: applications,
				focusState: $focusState
			)
		} else {
			self
		}
	}
}
