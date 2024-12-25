public enum ApplicationCacheState {
	case idle
	case loading(task: Task<Void, Never>) // TODO: ensure task is cancelled when setting state.
}
