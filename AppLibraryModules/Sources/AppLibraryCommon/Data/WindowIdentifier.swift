import AppKit

// TODO: Should this be an `enum`?

@frozen
public struct WindowIdentifier: RawRepresentable {
	public typealias RawValue = String

	public let rawValue: RawValue

	public init(rawValue: RawValue) {
		self.rawValue = rawValue
	}
}

// MARK: - Sendable

extension WindowIdentifier: Sendable { }

// MARK: - Equatable

extension WindowIdentifier: Equatable { }

// MARK: - Hashable

extension WindowIdentifier: Hashable { }

// MARK: - Identifiable

extension WindowIdentifier: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CustomStringConvertible

extension WindowIdentifier: CustomStringConvertible {
	public var description: String {
		"\(Self.self)(\(rawValue))"
	}
}

// MARK: - NSUserInterfaceItemIdentifierProtocol

extension WindowIdentifier: NSUserInterfaceItemIdentifierProtocol { }

// MARK: - Convenience

public extension WindowIdentifier {
	/// - Parameters:
	///   - rawValue:
	init(_ rawValue: RawValue) {
		self.init(rawValue: rawValue)
	}

	/// - Parameters:
	///   - rawValue:
	init<S>(rawValue: S) where
		S: StringProtocol
	{
		self.init(rawValue: RawValue(rawValue))
	}

	/// - Parameters:
	///   - rawValue:
	init<S>(_ rawValue: S) where
		S: StringProtocol
	{
		self.init(rawValue: rawValue)
	}
}

// MARK: - Constants

public extension WindowIdentifier {
	static let browser = Self("\(Bundle.main.bundleIdentifier!).Browser")

	static let settings = Self("com_apple_SwiftUI_Settings_window")

	static let about = Self("\(Bundle.main.bundleIdentifier!).About")
}

// MARK: -

public extension WindowIdentifier {
	/// The first ``NSWindow`` with this ID, if one could be found.
	@MainActor
	var window: NSWindow? {
		NSApplication.shared.windows.first { (window: NSWindow) -> Bool in
			window.identifier?.rawValue == rawValue
		}
	}

	/// All ``NSWindow``s with this ID.
	@MainActor
	var windows: some Sequence<NSWindow> {
		NSApplication.shared.windows.filter { (window: NSWindow) -> Bool in
			window.identifier?.rawValue == rawValue
		}
	}
}
