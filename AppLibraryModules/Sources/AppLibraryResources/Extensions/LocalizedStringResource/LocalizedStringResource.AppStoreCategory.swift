import Foundation
import LocalizationToolbox

public extension LocalizedStringResource {
	@available(*, deprecated)
	static var appStoreCategory: AppStoreCategory.Type { AppStoreCategory.self }

	/// ## Topics
	/// - ``appStoreCategory``
	@available(*, deprecated)
	enum AppStoreCategory {
		private static let localizationTable = LocalizationTableResource("AppStoreCategory")

		public static let books = LocalizedStringResource("BOOKS", table: Self.localizationTable)
		public static let business = LocalizedStringResource("BUSINESS", table: Self.localizationTable)
		public static let developerTools = LocalizedStringResource("DEVELOPER_TOOLS", table: Self.localizationTable)
		public static let education = LocalizedStringResource("EDUCATION", table: Self.localizationTable)
		public static let entertainment = LocalizedStringResource("ENTERTAINMENT", table: Self.localizationTable)
		public static let finance = LocalizedStringResource("FINANCE", table: Self.localizationTable)
		public static let foodAndDrink = LocalizedStringResource("FOOD_AND_DRINK", table: Self.localizationTable)
		public static let games = LocalizedStringResource("GAMES", table: Self.localizationTable)
		public static let actionGames = LocalizedStringResource("ACTION_GAMES", table: Self.localizationTable)
		public static let adventureGames = LocalizedStringResource("ADVENTURE_GAMES", table: Self.localizationTable)
		public static let arcadeGames = LocalizedStringResource("ARCADE_GAMES", table: Self.localizationTable)
		public static let boardGames = LocalizedStringResource("BOARD_GAMES", table: Self.localizationTable)
		public static let cardGames = LocalizedStringResource("CARD_GAMES", table: Self.localizationTable)
		public static let casinoGames = LocalizedStringResource("CASINO_GAMES", table: Self.localizationTable)
		public static let diceGames = LocalizedStringResource("DICE_GAMES", table: Self.localizationTable)
		public static let educationalGames = LocalizedStringResource("EDUCATIONAL_GAMES", table: Self.localizationTable)
		public static let familyGames = LocalizedStringResource("FAMILY_GAMES", table: Self.localizationTable)
		public static let kidsGames = LocalizedStringResource("KIDS_GAMES", table: Self.localizationTable)
		public static let musicGames = LocalizedStringResource("MUSIC_GAMES", table: Self.localizationTable)
		public static let puzzleGames = LocalizedStringResource("PUZZLE_GAMES", table: Self.localizationTable)
		public static let racingGames = LocalizedStringResource("RACING_GAMES", table: Self.localizationTable)
		public static let rolePlayingGames = LocalizedStringResource("ROLE_PLAYING_GAMES", table: Self.localizationTable)
		public static let simulationGames = LocalizedStringResource("SIMULATION_GAMES", table: Self.localizationTable)
		public static let sportsGames = LocalizedStringResource("SPORTS_GAMES", table: Self.localizationTable)
		public static let strategyGames = LocalizedStringResource("STRATEGY_GAMES", table: Self.localizationTable)
		public static let triviaGames = LocalizedStringResource("TRIVIA_GAMES", table: Self.localizationTable)
		public static let wordGames = LocalizedStringResource("WORD_GAMES", table: Self.localizationTable)
		public static let graphicsAndDesign = LocalizedStringResource("GRAPHICS_DESIGN", table: Self.localizationTable)
		public static let healthcareAndFitness = LocalizedStringResource("HEALTHCARE_FITNESS", table: Self.localizationTable)
		public static let lifestyle = LocalizedStringResource("LIFESTYLE", table: Self.localizationTable)
		public static let magazinesAndNewspapers = LocalizedStringResource("MAGAZINES_AND_NEWSPAPERS", table: Self.localizationTable)
		public static let medical = LocalizedStringResource("MEDICAL", table: Self.localizationTable)
		public static let music = LocalizedStringResource("MUSIC", table: Self.localizationTable)
		public static let navigation = LocalizedStringResource("NAVIGATION", table: Self.localizationTable)
		public static let news = LocalizedStringResource("NEWS", table: Self.localizationTable)
		public static let photography = LocalizedStringResource("PHOTOGRAPHY", table: Self.localizationTable)
		public static let productivity = LocalizedStringResource("PRODUCTIVITY", table: Self.localizationTable)
		public static let reference = LocalizedStringResource("REFERENCE", table: Self.localizationTable)
		public static let shopping = LocalizedStringResource("SHOPPING", table: Self.localizationTable)
		public static let socialNetworking = LocalizedStringResource("SOCIAL_NETWORKING", table: Self.localizationTable)
		public static let sports = LocalizedStringResource("SPORTS", table: Self.localizationTable)
		public static let travel = LocalizedStringResource("TRAVEL", table: Self.localizationTable)
		public static let utilities = LocalizedStringResource("UTILITIES", table: Self.localizationTable)
		public static let video = LocalizedStringResource("VIDEO", table: Self.localizationTable)
		public static let weather = LocalizedStringResource("WEATHER", table: Self.localizationTable)
	}
}
