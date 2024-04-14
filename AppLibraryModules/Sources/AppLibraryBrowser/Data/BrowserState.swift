enum BrowserState: Hashable, Sendable {
	case loading
	case complete
	case failed(reason: BrowserError?)
}
