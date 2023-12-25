enum MetadataQueryError: Error, Hashable, Sendable {
	case queryStartFailure
	case noSearchDirectories
}
