enum FeatureFlag {
	enum Application {
		/// If `true`, logs the initialization for an application.
		static let logMetadataInitialization: Bool
			= false

		/// If `true`, formats the metadata attribute keys for the application as a multi-line string.  If `false`, logs the array directly.
		static let formatMetadataAttributes: Bool
			= false

		/// Determine which implementation to use when creating the metadata query predicate in ``ApplicationCache``.
//		static let metadataDueryPredicateImplementation: PredicateImplementation
//			= .objc
	}
}
