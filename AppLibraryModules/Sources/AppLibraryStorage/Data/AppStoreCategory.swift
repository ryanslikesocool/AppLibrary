import Foundation

public enum AppStoreCategory: String {
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

	// TODO: Should arbitrary categories be supported?
	// Or should other categories all fall under a single "other" case?
//	case some(String)
}

// MARK: - Sendable

extension AppStoreCategory: Sendable { }

// MARK: - Equatable

extension AppStoreCategory: Equatable { }

// MARK: - Hashable

extension AppStoreCategory: Hashable { }

// MARK: - CaseIterable

extension AppStoreCategory: CaseIterable { }

// MARK: - CustomLocalizedStringResourceConvertible

extension AppStoreCategory: CustomLocalizedStringResourceConvertible {
	public var localizedStringResource: LocalizedStringResource {
		// TODO: Should this be pre-computed as a `static let` dictionary?
		// Or is the Swift compiler smart enough to optimize this away?
		LocalizedStringResource(
			String.LocalizationValue(rawValue),
			table: Self.localizationTableName
		)
	}

	// TODO: Is there a built-in string table for category names somewhere?
	// Maybe in `App Store.app`?

	// Localized names might be provided by `NSMetadataItemAttribute.AppStoreCategoryKey`,
	// which is different from `NSMetadataItemAttribute.AppStoreCategoryTypeKey`.
}

// MARK: - Constants

private extension AppStoreCategory {
	static let localizationTableName: String = "AppStoreCategory"
}
