extension MetadataQueryV2 {
	enum Failure: Swift.Error {
		case queryStartFailure
		case queryCompletionFailure
		case noSearchScopes
	}
}