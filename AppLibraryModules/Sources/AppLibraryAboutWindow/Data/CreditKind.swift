import AppIntents
import AcknowledgementToolbox
import AppLibraryResources
import Foundation
import SFSymbolToolbox

enum CreditKind {
	case contributor
	case acknowledgement
}

// MARK: - Sendable

extension CreditKind: Sendable { }

// MARK: - Equatable

extension CreditKind: Equatable { }

// MARK: - Hashable

extension CreditKind: Hashable { }

// MARK: - CaseIterable

extension CreditKind: CaseIterable { }

// MARK: - CaseDisplayRepresentable

extension CreditKind: CaseDisplayRepresentable  {
	public static let caseDisplayRepresentations: [Self : DisplayRepresentation] = [
		.contributor: DisplayRepresentation(
			title: LocalizedStringResource("SECTION.CONTRIBUTORS.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .person_3),
		),

		.acknowledgement: DisplayRepresentation(
			title: LocalizedStringResource("SECTION.ACKNOWLEDGEMENTS.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .building_columns),
		),
	]
}

// MARK: - Constants

private extension CreditKind {
	static let localizationTable = "Credits"
}

// MARK: -

extension CreditKind {
	var systemImageName: SystemSymbolName {
		switch self {
			case .contributor: .person_3
			case .acknowledgement: .building_columns
		}
	}
}
