enum FeatureFlag {
	enum Log {
#if DEBUG
		static let startXPCRequest: Bool = true
#endif
	}
}
