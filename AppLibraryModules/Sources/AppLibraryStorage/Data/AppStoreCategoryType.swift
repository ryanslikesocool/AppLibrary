import AppLibraryResources
import Foundation

public enum AppStoreCategoryType: String {
	case books = "public.app-category.books"
	case business = "public.app-category.business"
	case developerTools = "public.app-category.developer-tools"
	case education = "public.app-category.education"
	case entertainment = "public.app-category.entertainment"
	case finance = "public.app-category.finance"
	case foodAndDrink = "public.app-category.food-and-drink"
	case games = "public.app-category.games"
	case actionGames = "public.app-category.action-games"
	case adventureGames = "public.app-category.adventure-games"
	case arcadeGames = "public.app-category.arcade-games"
	case boardGames = "public.app-category.board-games"
	case cardGames = "public.app-category.card-games"
	case casinoGames = "public.app-category.casino-games"
	case diceGames = "public.app-category.dice-games"
	case educationalGames = "public.app-category.educational-games"
	case familyGames = "public.app-category.family-games"
	case kidsGames = "public.app-category.kids-games"
	case musicGames = "public.app-category.music-games"
	case puzzleGames = "public.app-category.puzzle-games"
	case racingGames = "public.app-category.racing-games"
	case rolePlayingGames = "public.app-category.role-playing-games"
	case simulationGames = "public.app-category.simulation-games"
	case sportsGames = "public.app-category.sports-games"
	case strategyGames = "public.app-category.strategy-games"
	case triviaGames = "public.app-category.trivia-games"
	case wordGames = "public.app-category.word-games"
	case graphicsAndDesign = "public.app-category.graphics-design"
	case healthcareAndFitness = "public.app-category.healthcare-fitness"
	case lifestyle = "public.app-category.lifestyle"
	case magazinesAndNewspapers = "public.app-category.magazines-and-newspapers"
	case medical = "public.app-category.medical"
	case music = "public.app-category.music"
	case navigation = "public.app-category.navigation"
	case news = "public.app-category.news"
	case photography = "public.app-category.photography"
	case productivity = "public.app-category.productivity"
	case reference = "public.app-category.reference"
	case shopping = "public.app-category.shopping"
	case socialNetworking = "public.app-category.social-networking"
	case sports = "public.app-category.sports"
	case travel = "public.app-category.travel"
	case utilities = "public.app-category.utilities"
	case video = "public.app-category.video"
	case weather = "public.app-category.weather"

	// TODO: Should arbitrary app store category types be supported?
//	case some(String)
	// Or should other app store category types all fall under a single "unknown" case?
//	case unknown
}

// MARK: - Sendable

extension AppStoreCategoryType: Sendable { }

// MARK: - Equatable

extension AppStoreCategoryType: Equatable { }

// MARK: - Hashable

extension AppStoreCategoryType: Hashable { }

// MARK: - CaseIterable

extension AppStoreCategoryType: CaseIterable { }

// MARK: - CustomLocalizedStringResourceConvertible

extension AppStoreCategoryType: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should this be pre-computed as a `static let` dictionary?
		// - Should we fall back to the old approach, where the `rawValue` is the localization key?

		switch self {
			case .books: .appStoreCategory.books
			case .business: .appStoreCategory.business
			case .developerTools: .appStoreCategory.developerTools
			case .education: .appStoreCategory.education
			case .entertainment: .appStoreCategory.entertainment
			case .finance: .appStoreCategory.finance
			case .foodAndDrink: .appStoreCategory.foodAndDrink
			case .games: .appStoreCategory.games
			case .actionGames: .appStoreCategory.actionGames
			case .adventureGames: .appStoreCategory.adventureGames
			case .arcadeGames: .appStoreCategory.arcadeGames
			case .boardGames: .appStoreCategory.boardGames
			case .cardGames: .appStoreCategory.cardGames
			case .casinoGames: .appStoreCategory.casinoGames
			case .diceGames: .appStoreCategory.diceGames
			case .educationalGames: .appStoreCategory.educationalGames
			case .familyGames: .appStoreCategory.familyGames
			case .kidsGames: .appStoreCategory.kidsGames
			case .musicGames: .appStoreCategory.musicGames
			case .puzzleGames: .appStoreCategory.puzzleGames
			case .racingGames: .appStoreCategory.racingGames
			case .rolePlayingGames: .appStoreCategory.rolePlayingGames
			case .simulationGames: .appStoreCategory.simulationGames
			case .sportsGames: .appStoreCategory.sportsGames
			case .strategyGames: .appStoreCategory.strategyGames
			case .triviaGames: .appStoreCategory.triviaGames
			case .wordGames: .appStoreCategory.wordGames
			case .graphicsAndDesign: .appStoreCategory.graphicsAndDesign
			case .healthcareAndFitness: .appStoreCategory.healthcareAndFitness
			case .lifestyle: .appStoreCategory.lifestyle
			case .magazinesAndNewspapers: .appStoreCategory.magazinesAndNewspapers
			case .medical: .appStoreCategory.medical
			case .music: .appStoreCategory.music
			case .navigation: .appStoreCategory.navigation
			case .news: .appStoreCategory.news
			case .photography: .appStoreCategory.photography
			case .productivity: .appStoreCategory.productivity
			case .reference: .appStoreCategory.reference
			case .shopping: .appStoreCategory.shopping
			case .socialNetworking: .appStoreCategory.socialNetworking
			case .sports: .appStoreCategory.sports
			case .travel: .appStoreCategory.travel
			case .utilities: .appStoreCategory.utilities
			case .video: .appStoreCategory.video
			case .weather: .appStoreCategory.weather
		}
	}

	// TODO: Is there a built-in string table for category names somewhere?
	// Maybe in `App Store.app`?

	// Localized names might be provided by `NSMetadataItemAttribute.AppStoreCategoryKey`,
	// which is different from `NSMetadataItemAttribute.AppStoreCategoryTypeKey`.
}
