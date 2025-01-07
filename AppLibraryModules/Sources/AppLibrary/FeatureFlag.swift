enum FeatureFlag { }

// MARK: - Main Menu

extension FeatureFlag {
	enum MainMenu {
		/// When `true`, log debug information when initializing the ``MainMenu``.
		static let logInitialization: Bool
			= true

		/// When `true`, log debug information when invoking an action in the ``MainMenu``.
		static let logAction: Bool
			= true
	}
}