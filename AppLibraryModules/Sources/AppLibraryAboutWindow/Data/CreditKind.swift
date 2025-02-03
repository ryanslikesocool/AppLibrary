import AcknowledgementToolbox
import AppLibraryResources
import Foundation
import SFSymbolToolbox

enum CreditKind {
	case contributor
	case acknowledgement
}

// MARK: - CustomLocalizedStringResourceConvertible

extension CreditKind: CustomLocalizedStringResourceConvertible {
	var localizedStringResource: LocalizedStringResource {
		switch self {
			case .contributor: .credits.section.contributors.title
			case .acknowledgement: .credits.section.acknowledgements.title
		}
	}
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
