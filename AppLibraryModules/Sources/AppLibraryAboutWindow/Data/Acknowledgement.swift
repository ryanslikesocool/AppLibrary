import Foundation

struct Acknowledgement {
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

extension Acknowledgement: Sendable { }

// MARK: - Decodable

extension Acknowledgement: Decodable {
	private enum CodingKeys: CodingKey {
		case name
		case projectURL
		case licenseURL
		case licensePath
	}

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		let name = try container.decode(String.self, forKey: .name)
		let projectURL = try container.decode(URL.self, forKey: .projectURL)

		let licenseURL: URL
		if let decodedLicenseURL = try container.decodeIfPresent(URL.self, forKey: .licenseURL) {
			licenseURL = decodedLicenseURL
		} else if let decodedLicensePath = try container.decodeIfPresent(String.self, forKey: .licensePath) {
			licenseURL = projectURL.appending(path: decodedLicensePath)
		} else {
			throw DecodingError.keyNotFound(
				CodingKeys.licenseURL,
				DecodingError.Context(
					codingPath: decoder.codingPath,
					debugDescription: "Failed to retrieve the value for either `\(CodingKeys.licenseURL)` or `\(CodingKeys.licensePath)`."
				)
			)
		}

		self.init(
			name: name,
			projectURL: projectURL,
			licenseURL: licenseURL
		)
	}
}

// MARK: - CreditProtocol

extension Acknowledgement: CreditProtocol {
	typealias TopLevelDecoder = JSONDecoder

	static var fileURL: URL? {
		Bundle.main.url(forResource: "Acknowledgements", withExtension: "json")
	}

	static let modelKeyPath: KeyPath<AboutWindowModel, [Self]> = \.acknowledgements
}
