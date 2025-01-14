import UniformTypeIdentifiers

// MARK: - Constants

public extension UTType {
	static let applicationPlaceholder: Self! = Self("com.apple.application-placeholder")
}

// MARK: AppStoreCategory

public extension UTType {
	static let appStoreCategory = AppStoreCategory.self

	/// ## Topics
	/// - ``appStoreCategory``
	enum AppStoreCategory {
		public static let books: UTType! = UTType("public.app-category.books")
		public static let business: UTType! = UTType("public.app-category.business")
		public static let developerTools: UTType! = UTType("public.app-category.developer-tools")
		public static let education: UTType! = UTType("public.app-category.education")
		public static let entertainment: UTType! = UTType("public.app-category.entertainment")
		public static let finance: UTType! = UTType("public.app-category.finance")
		public static let foodAndDrink: UTType! = UTType("public.app-category.food-and-drink")
		public static let games: UTType! = UTType("public.app-category.games")
		public static let actionGames: UTType! = UTType("public.app-category.action-games")
		public static let adventureGames: UTType! = UTType("public.app-category.adventure-games")
		public static let arcadeGames: UTType! = UTType("public.app-category.arcade-games")
		public static let boardGames: UTType! = UTType("public.app-category.board-games")
		public static let cardGames: UTType! = UTType("public.app-category.card-games")
		public static let casinoGames: UTType! = UTType("public.app-category.casino-games")
		public static let diceGames: UTType! = UTType("public.app-category.dice-games")
		public static let educationalGames: UTType! = UTType("public.app-category.educational-games")
		public static let familyGames: UTType! = UTType("public.app-category.family-games")
		public static let kidsGames: UTType! = UTType("public.app-category.kids-games")
		public static let musicGames: UTType! = UTType("public.app-category.music-games")
		public static let puzzleGames: UTType! = UTType("public.app-category.puzzle-games")
		public static let racingGames: UTType! = UTType("public.app-category.racing-games")
		public static let rolePlayingGames: UTType! = UTType("public.app-category.role-playing-games")
		public static let simulationGames: UTType! = UTType("public.app-category.simulation-games")
		public static let sportsGames: UTType! = UTType("public.app-category.sports-games")
		public static let strategyGames: UTType! = UTType("public.app-category.strategy-games")
		public static let triviaGames: UTType! = UTType("public.app-category.trivia-games")
		public static let wordGames: UTType! = UTType("public.app-category.word-games")
		public static let graphicsAndDesign: UTType! = UTType("public.app-category.graphics-design")
		public static let healthcareAndFitness: UTType! = UTType("public.app-category.healthcare-fitness")
		public static let lifestyle: UTType! = UTType("public.app-category.lifestyle")
		public static let magazinesAndNewspapers: UTType! = UTType("public.app-category.magazines-and-newspapers")
		public static let medical: UTType! = UTType("public.app-category.medical")
		public static let music: UTType! = UTType("public.app-category.music")
		public static let navigation: UTType! = UTType("public.app-category.navigation")
		public static let news: UTType! = UTType("public.app-category.news")
		public static let photography: UTType! = UTType("public.app-category.photography")
		public static let productivity: UTType! = UTType("public.app-category.productivity")
		public static let reference: UTType! = UTType("public.app-category.reference")
		public static let shopping: UTType! = UTType("public.app-category.shopping")
		public static let socialNetworking: UTType! = UTType("public.app-category.social-networking")
		public static let sports: UTType! = UTType("public.app-category.sports")
		public static let travel: UTType! = UTType("public.app-category.travel")
		public static let utilities: UTType! = UTType("public.app-category.utilities")
		public static let video: UTType! = UTType("public.app-category.video")
		public static let weather: UTType! = UTType("public.app-category.weather")
	}
}
