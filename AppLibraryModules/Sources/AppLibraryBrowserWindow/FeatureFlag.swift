import AppLibraryStorage

enum FeatureFlag {
	enum ApplicationIcon {
		static let implementation: ApplicationIconFunctionImplementation
			= .manualPath

		static let logSuccessfulResult: Bool
			= false

		static let measureTime: Bool
			= false
	}
}
