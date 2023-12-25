enum BrowserQueryState: Hashable, Sendable {
	case loading
	case complete
	case failed(reason: MetadataQueryError?)
}
