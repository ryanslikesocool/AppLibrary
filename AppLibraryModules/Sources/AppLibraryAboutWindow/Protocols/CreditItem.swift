import AcknowledgementToolbox
import LocalizationToolbox

protocol CreditItem: StoredAcknowledgementItem where
	Model == AboutWindowModel
{
	associatedtype ItemView: CreditItemView where ItemView.Value == Self

	static var creditKind: CreditKind { get }
}
