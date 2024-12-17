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

// MARK: - Acknowledgement

extension Contributor: Acknowledgement {
	typealias Decoder = JSONDecoder

	static var fileURL: URL? {
		Bundle.module.url(forResource: "Contributors", withExtension: "json")
	}

	static let modelKeyPath: KeyPath<AboutWindowModel, [Self]> = \.contributors
}
