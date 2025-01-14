import AppLibraryResources
import Foundation
import UniformTypeIdentifiers

public enum AppStoreCategoryType {
	case books
	case business
	case developerTools
	case education
	case entertainment
	case finance
	case foodAndDrink
	case games
	case actionGames
	case adventureGames
	case arcadeGames
	case boardGames
	case cardGames
	case casinoGames
	case diceGames
	case educationalGames
	case familyGames
	case kidsGames
	case musicGames
	case puzzleGames
	case racingGames
	case rolePlayingGames
	case simulationGames
	case sportsGames
	case strategyGames
	case triviaGames
	case wordGames
	case graphicsAndDesign
	case healthcareAndFitness
	case lifestyle
	case magazinesAndNewspapers
	case medical
	case music
	case navigation
	case news
	case photography
	case productivity
	case reference
	case shopping
	case socialNetworking
	case sports
	case travel
	case utilities
	case video
	case weather
}

// MARK: - RawRepresentable

// NOTE: We can't assign constants to each `case` directly,
// so we have to manually implement `RawRepresentable`.
extension AppStoreCategoryType: RawRepresentable {
	public typealias RawValue = UTType

	public init?(rawValue: RawValue) {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should we store this as a `static let rawValueInitializerLookupTable: [RawValue : Self]`?
		// - Should `switch` cases be `case Self.<case>.rawValue:` for safety?
		// - Should we implement this using `Self.allCases`?
		//		```swift
		//		guard let result = Self.allCases.first(where: { (element: Self) -> Bool in
		//			element.rawValue == rawValue
		//		}) else {
		//			return nil
		//		}
		//		self = result
		//		```

		self.init(where: \.rawValue, equals: rawValue)

//		switch rawValue {
//			case UTType.AppStoreCategory.books: self = Self.books
//			case UTType.AppStoreCategory.business: self = Self.business
//			case UTType.AppStoreCategory.developerTools: self = Self.developerTools
//			case UTType.AppStoreCategory.education: self = Self.education
//			case UTType.AppStoreCategory.entertainment: self = Self.entertainment
//			case UTType.AppStoreCategory.finance: self = Self.finance
//			case UTType.AppStoreCategory.foodAndDrink: self = Self.foodAndDrink
//			case UTType.AppStoreCategory.games: self = Self.games
//			case UTType.AppStoreCategory.actionGames: self = Self.actionGames
//			case UTType.AppStoreCategory.adventureGames: self = Self.adventureGames
//			case UTType.AppStoreCategory.arcadeGames: self = Self.arcadeGames
//			case UTType.AppStoreCategory.boardGames: self = Self.boardGames
//			case UTType.AppStoreCategory.cardGames: self = Self.cardGames
//			case UTType.AppStoreCategory.casinoGames: self = Self.casinoGames
//			case UTType.AppStoreCategory.diceGames: self = Self.diceGames
//			case UTType.AppStoreCategory.educationalGames: self = Self.educationalGames
//			case UTType.AppStoreCategory.familyGames: self = Self.familyGames
//			case UTType.AppStoreCategory.kidsGames: self = Self.kidsGames
//			case UTType.AppStoreCategory.musicGames: self = Self.musicGames
//			case UTType.AppStoreCategory.puzzleGames: self = Self.puzzleGames
//			case UTType.AppStoreCategory.racingGames: self = Self.racingGames
//			case UTType.AppStoreCategory.rolePlayingGames: self = Self.rolePlayingGames
//			case UTType.AppStoreCategory.simulationGames: self = Self.simulationGames
//			case UTType.AppStoreCategory.sportsGames: self = Self.sportsGames
//			case UTType.AppStoreCategory.strategyGames: self = Self.strategyGames
//			case UTType.AppStoreCategory.triviaGames: self = Self.triviaGames
//			case UTType.AppStoreCategory.wordGames: self = Self.wordGames
//			case UTType.AppStoreCategory.graphicsAndDesign: self = Self.graphicsAndDesign
//			case UTType.AppStoreCategory.healthcareAndFitness: self = Self.healthcareAndFitness
//			case UTType.AppStoreCategory.lifestyle: self = Self.lifestyle
//			case UTType.AppStoreCategory.magazinesAndNewspapers: self = Self.magazinesAndNewspapers
//			case UTType.AppStoreCategory.medical: self = Self.medical
//			case UTType.AppStoreCategory.music: self = Self.music
//			case UTType.AppStoreCategory.navigation: self = Self.navigation
//			case UTType.AppStoreCategory.news: self = Self.news
//			case UTType.AppStoreCategory.photography: self = Self.photography
//			case UTType.AppStoreCategory.productivity: self = Self.productivity
//			case UTType.AppStoreCategory.reference: self = Self.reference
//			case UTType.AppStoreCategory.shopping: self = Self.shopping
//			case UTType.AppStoreCategory.socialNetworking: self = Self.socialNetworking
//			case UTType.AppStoreCategory.sports: self = Self.sports
//			case UTType.AppStoreCategory.travel: self = Self.travel
//			case UTType.AppStoreCategory.utilities: self = Self.utilities
//			case UTType.AppStoreCategory.video: self = Self.video
//			case UTType.AppStoreCategory.weather: self = Self.weather
//			default: return nil
//		}
	}

	public var rawValue: RawValue {
		// TODO: Optimize
		// - Is the Swift compiler already smart enough to optimize this away?
		// - Should we store this as a `static let rawValueLookupTable: [Self : RawValue]`?

		switch self {
			case Self.books: UTType.AppStoreCategory.books
			case Self.business: UTType.AppStoreCategory.business
			case Self.developerTools: UTType.AppStoreCategory.developerTools
			case Self.education: UTType.AppStoreCategory.education
			case Self.entertainment: UTType.AppStoreCategory.entertainment
			case Self.finance: UTType.AppStoreCategory.finance
			case Self.foodAndDrink: UTType.AppStoreCategory.foodAndDrink
			case Self.games: UTType.AppStoreCategory.games
			case Self.actionGames: UTType.AppStoreCategory.actionGames
			case Self.adventureGames: UTType.AppStoreCategory.adventureGames
			case Self.arcadeGames: UTType.AppStoreCategory.arcadeGames
			case Self.boardGames: UTType.AppStoreCategory.boardGames
			case Self.cardGames: UTType.AppStoreCategory.cardGames
			case Self.casinoGames: UTType.AppStoreCategory.casinoGames
			case Self.diceGames: UTType.AppStoreCategory.diceGames
			case Self.educationalGames: UTType.AppStoreCategory.educationalGames
			case Self.familyGames: UTType.AppStoreCategory.familyGames
			case Self.kidsGames: UTType.AppStoreCategory.kidsGames
			case Self.musicGames: UTType.AppStoreCategory.musicGames
			case Self.puzzleGames: UTType.AppStoreCategory.puzzleGames
			case Self.racingGames: UTType.AppStoreCategory.racingGames
			case Self.rolePlayingGames: UTType.AppStoreCategory.rolePlayingGames
			case Self.simulationGames: UTType.AppStoreCategory.simulationGames
			case Self.sportsGames: UTType.AppStoreCategory.sportsGames
			case Self.strategyGames: UTType.AppStoreCategory.strategyGames
			case Self.triviaGames: UTType.AppStoreCategory.triviaGames
			case Self.wordGames: UTType.AppStoreCategory.wordGames
			case Self.graphicsAndDesign: UTType.AppStoreCategory.graphicsAndDesign
			case Self.healthcareAndFitness: UTType.AppStoreCategory.healthcareAndFitness
			case Self.lifestyle: UTType.AppStoreCategory.lifestyle
			case Self.magazinesAndNewspapers: UTType.AppStoreCategory.magazinesAndNewspapers
			case Self.medical: UTType.AppStoreCategory.medical
			case Self.music: UTType.AppStoreCategory.music
			case Self.navigation: UTType.AppStoreCategory.navigation
			case Self.news: UTType.AppStoreCategory.news
			case Self.photography: UTType.AppStoreCategory.photography
			case Self.productivity: UTType.AppStoreCategory.productivity
			case Self.reference: UTType.AppStoreCategory.reference
			case Self.shopping: UTType.AppStoreCategory.shopping
			case Self.socialNetworking: UTType.AppStoreCategory.socialNetworking
			case Self.sports: UTType.AppStoreCategory.sports
			case Self.travel: UTType.AppStoreCategory.travel
			case Self.utilities: UTType.AppStoreCategory.utilities
			case Self.video: UTType.AppStoreCategory.video
			case Self.weather: UTType.AppStoreCategory.weather
		}
	}
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
		// - Should we store this as a `static let localizedStringResourceLookupTable: [Self : LocalizedStringResource]`?
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

	// Localized names might be provided by `NSMetadataItemAttributeKeys.AppStoreCategory`,
	// which is different from `NSMetadataItemAttributeKeys.AppStoreCategoryType`.
}
