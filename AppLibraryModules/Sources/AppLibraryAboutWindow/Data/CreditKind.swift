import AcknowledgementToolbox
import Foundation

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
