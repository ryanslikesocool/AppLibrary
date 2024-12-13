extension MetadataQueryV1 {
	enum Failure: Swift.Error {
		case queryStartFailure
		case queryCompletionFailure
	}
}
