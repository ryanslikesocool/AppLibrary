import Foundation

public struct ApplicationIdentifier {
	public let bundleIdentifier: String
	public let version: String?

	@available(*, deprecated)
	public let displayName: String // TODO: remove

	public init(
		_ bundleIdentifier: String,
		version: String? = nil,
		displayName: String
	) {
		self.bundleIdentifier = bundleIdentifier
		self.version = version
		self.displayName = displayName
	}
}

// MARK: - Sendable

extension ApplicationIdentifier: Sendable { }

// MARK: - Equatable

@available(*, deprecated)
extension ApplicationIdentifier: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.bundleIdentifier == rhs.bundleIdentifier
			&& lhs.version == rhs.version
	}
}

// MARK: - Hashable

@available(*, deprecated)
extension ApplicationIdentifier: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(bundleIdentifier)
		hasher.combine(version)
	}
}

// MARK: - Identifiable

extension ApplicationIdentifier: Identifiable {
	public var id: Self { self }
}

// MARK: - Codable

extension ApplicationIdentifier: Codable { }
