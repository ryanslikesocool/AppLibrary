struct DefaultApplicationCacheDelegate: ApplicationCacheDelegate {
	private init() { }

	public static let shared: Self = Self()
}