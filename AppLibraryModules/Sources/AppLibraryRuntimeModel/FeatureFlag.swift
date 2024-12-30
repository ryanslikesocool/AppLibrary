enum FeatureFlag {
	enum Application {
		static let logInstance: Bool
			= false

		enum Icon {
			static let logSuccessfulResult: Bool
				= false

			static let measureTime: Bool
				= false
		}
	}
}
