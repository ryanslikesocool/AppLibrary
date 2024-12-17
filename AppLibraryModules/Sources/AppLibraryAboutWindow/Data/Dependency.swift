import Foundation

struct Dependency {
	public let name: String
	public let projectURL: URL
	public let licenseURL: URL

	private init(
		name: String,
		projectURL: URL,
		licenseURL: URL
	) {
		self.name = name
		self.projectURL = projectURL
		self.licenseURL = licenseURL
	}
}

// MARK: - Sendable

extension Dependency: Sendable { }

// MARK: - Decodable

extension Dependency: Decodable { }

// MARK: - Acknowledgement

extension Dependency: Acknowledgement {
	typealias Decoder = JSONDecoder

	static var fileURL: URL? {
		Bundle.module.url(forResource: "Dependencies", withExtension: "json")
	}

	static let modelKeyPath: KeyPath<AboutWindowModel, [Self]> = \.dependencies
}
