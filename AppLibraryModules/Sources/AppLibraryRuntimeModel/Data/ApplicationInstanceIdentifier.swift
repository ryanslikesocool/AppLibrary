import AppLibraryStorage
import Foundation

public struct ApplicationInstanceIdentifier {
	public let bundleIdentifier: String
	public let url: URL

	public init(bundleIdentifier: String, url: URL) {
		self.bundleIdentifier = bundleIdentifier
		self.url = url
	}
}

// MARK: - Sendable

extension ApplicationInstanceIdentifier: Sendable { }

// MARK: - Equatable

extension ApplicationInstanceIdentifier: Equatable { }

// MARK: - Hashable

extension ApplicationInstanceIdentifier: Hashable { }

// MARK: - CustomStringConvertible

extension ApplicationInstanceIdentifier: CustomStringConvertible {
	public var description: String {
		"\(Self.self)(bundleIdentifier: \(bundleIdentifier), url: \(url))"
	}
}

// MARK: - Convenience

public extension ApplicationInstanceIdentifier {
	init(
		_ modelIdentifier: borrowing ApplicationModelIdentifier,
		url: URL
	) {
		self.init(bundleIdentifier: modelIdentifier.bundleIdentifier, url: url)
	}

	init(
		bundleIdentifier: String,
		_ instance: borrowing ApplicationInstance
	) {
		self.init(bundleIdentifier: bundleIdentifier, url: instance.url)
	}

	init(
		_ model: ApplicationModel,
		_ instance: borrowing ApplicationInstance
	) {
		self.init(bundleIdentifier: model.bundleIdentifier, url: instance.url)
	}
}
