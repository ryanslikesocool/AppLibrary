import AppLibraryStorage

enum FeatureFlag { }

// MARK: - ApplicationIcon

extension FeatureFlag {
	enum ApplicationIcon {
		static let implementation: ApplicationIconFunctionImplementation
			= .manualPath

		static let logSuccessfulResult: Bool
			= false

		static let measureTime: Bool
			= false
	}
}

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
