import AcknowledgementToolbox
import Foundation

struct Contributor {
	public let name: String
	public let personalURL: URL?
	public let githubURL: URL?

	private init(
		name: String,
		personalURL: URL?,
		githubURL: URL?
	) {
		self.name = name
		self.personalURL = personalURL
		self.githubURL = githubURL
	}
}

// MARK: - Sendable

extension Contributor: Sendable { }

// MARK: - Decodable

extension Contributor: Decodable { }

// MARK: - PrimitiveAcknowledgementItem

extension Contributor: PrimitiveAcknowledgementItem { }

// MARK: - DecodableAcknowledgementItem

extension Contributor: DecodableAcknowledgementItem {
	static var topLevelDecoder: JSONDecoder {
		.shared
	}

	static var fileURL: URL? {
		Bundle.main.url(
			forResource: "Contributors",
			withExtension: "json"
		)
	}
}

// MARK: - StoredAcknowledgementItem

extension Contributor: StoredAcknowledgementItem {
	static let modelKeyPath = \AboutWindowModel.contributors
}

// MARK: - CreditItem

extension Contributor: CreditItem {
	static let creditKind: CreditKind = .contributor
}