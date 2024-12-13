extension MetadataQuery {
	enum Failure: Swift.Error {
		case queryStartFailure
		case queryCompletionFailure
	}
}
