import Foundation

public struct ApplicationIdentifier {
	public let bundleIdentifier: String

	@available(*, deprecated)
	public let displayName: String // TODO: remove

	public init(
		_ bundleIdentifier: String,
		displayName: String
	) {
		self.bundleIdentifier = bundleIdentifier
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
	}
}

// MARK: - Hashable

@available(*, deprecated)
extension ApplicationIdentifier: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(bundleIdentifier)
	}
}

// MARK: - Identifiable

extension ApplicationIdentifier: Identifiable {
	public var id: Self { self }
}

// MARK: - Codable

extension ApplicationIdentifier: Codable { }
