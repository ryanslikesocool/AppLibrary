import Foundation

public struct ApplicationIdentifier {
	public let bundleIdentifier: String
//	public let url: URL // TODO: add url as unique parameter
	public let version: String?

	@available(*, deprecated)
	public let displayName: String // TODO: remove

	public init(
		_ bundleIdentifier: String,
		displayName: String,
//		url: URL,
		version: String? = nil
	) {
		self.bundleIdentifier = bundleIdentifier
		self.displayName = displayName
//		self.url = url
		self.version = version
	}
}

// MARK: - Sendable

extension ApplicationIdentifier: Sendable { }

// MARK: - Equatable

@available(*, deprecated)
extension ApplicationIdentifier: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.bundleIdentifier == rhs.bundleIdentifier
//			&& lhs.url == rhs.url
			&& lhs.version == rhs.version
	}
}

// MARK: - Hashable

@available(*, deprecated)
extension ApplicationIdentifier: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(bundleIdentifier)
//		hasher.combine(url)
		hasher.combine(version)
	}
}

// MARK: - Identifiable

extension ApplicationIdentifier: Identifiable {
	public var id: Self { self }
}

// MARK: - Codable

extension ApplicationIdentifier: Codable { }
