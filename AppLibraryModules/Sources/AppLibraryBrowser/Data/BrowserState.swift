import AppLibraryStorage

enum BrowserState {
	case idle
	case loading
	case error(BrowserError)
}
