extension ApplicationSearchScopesEditorViewModel {
	enum State {
		case idle

		case fileImporter
	}
}

// MARK: - Sendable

extension ApplicationSearchScopesEditorViewModel.State: Sendable { }

// MARK: - Equatable

extension ApplicationSearchScopesEditorViewModel.State: Equatable { }

// MARK: - Hashable

extension ApplicationSearchScopesEditorViewModel.State: Hashable { }

// MARK: -

extension ApplicationSearchScopesEditorViewModel.State {
	subscript(state: Self) -> Bool {
		get { self == state }
		set {
			self = if newValue {
				state
			} else {
				.idle
			}
		}
	}
}