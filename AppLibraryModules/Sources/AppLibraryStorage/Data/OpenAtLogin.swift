import AppIntents
import OSLog
import ServiceManagement

public struct OpenAtLogin {
	public var isEnabled: Bool {
		get { Self.get() }
		set {
			guard newValue != isEnabled else {
				return
			}
			Self.set(newValue)
		}
	}

	init() { }
}

// MARK: - Sendable

extension OpenAtLogin: Sendable { }

// MARK: - Equatable

extension OpenAtLogin: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.isEnabled == rhs.isEnabled
	}
}

// MARK: - Hashable

extension OpenAtLogin: Hashable {
	public func hash(into hasher: inout Hasher) {
		hasher.combine(isEnabled)
	}
}

// MARK: - ExpressibleByBooleanLiteral

extension OpenAtLogin: ExpressibleByBooleanLiteral {
	public init(booleanLiteral value: BooleanLiteralType) {
		self.init()
		isEnabled = value
	}
}

// MARK: - TypeDisplayRepresentable

extension OpenAtLogin: TypeDisplayRepresentable {
	public static let typeDisplayRepresentation = TypeDisplayRepresentation(
		name: LocalizedStringResource("TITLE", table: Self.localizationTable),
	)
}

// MARK: - Constants

private extension OpenAtLogin {
	static let localizationTable = "OpenAtLoginToggle"
}

// MARK: -

private extension OpenAtLogin {
	static func get() -> Bool {
		SMAppService.mainApp.status == .enabled
	}

	static func set(_ newValue: Bool) {
		do {
			if newValue {
				try SMAppService.mainApp.register()
			} else {
				try SMAppService.mainApp.unregister()
			}
		} catch {
			Logger.module.error("""
			Failed to set \(Self.self).\(#function) to '\(newValue)':
			- Error: \(error)
			""")
		}
	}
}
