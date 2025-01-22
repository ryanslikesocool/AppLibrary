import AcknowledgementToolbox
import AppLibraryCommon
import Foundation

final class AboutWindowModel: AcknowledgementStore, AcknowledgementStoreProtocol {
	private(set) var acknowledgements: [Acknowledgement]
	private(set) var contributors: [Contributor]

	override init() {
		acknowledgements = []
		contributors = []

		super.init()
	}
}
