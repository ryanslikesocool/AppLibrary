enum BrowserState {
	case loading(task: Task<Void, Never>) // TODO: ensure task is cancelled when setting state.
	case complete
	case failed(reason: BrowserError)
}