import AppLibraryStorage

enum FeatureFlag { }

// MARK: - Dock

extension FeatureFlag {
	enum Dock {
		static let edgeEstimationImplementation: DockEdgeEstimationImplementation
			= .screenRect

#if DEBUG
		static let logAccessibilityElements: Bool
			= false

		static let logEdgeEstimationImplementationResultComparison: Bool
			= false
#endif
	}
}
