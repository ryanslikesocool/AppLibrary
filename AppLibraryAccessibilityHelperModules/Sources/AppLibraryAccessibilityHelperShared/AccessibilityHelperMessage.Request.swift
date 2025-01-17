import Foundation

public extension AccessibilityHelperMessage {
	enum Request {
		case dockTileRect(DockTileRect)
		case dockEstimatedEdge(DockEstimatedEdge)
		case dockRectAndEstimatedEdge(DockRectAndEstimatedEdge)
		case requestAccessibilityAccess(RequestAccessibilityAccess)
	}
}

// MARK: - Codable

extension AccessibilityHelperMessage.Request: Codable {
	private typealias CodingKeys = Super.CodingKeys

	public init(from decoder: any Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		var allKeys = ArraySlice(container.allKeys)

		guard
			let onlyKey = allKeys.popFirst(),
			allKeys.isEmpty
		else {
			throw DecodingError.typeMismatch(
				Self.self,
				DecodingError.Context(
					codingPath: container.codingPath,
					debugDescription: "Invalid number of keys found, expected one.",
					underlyingError: nil
				)
			)
		}

		self = switch onlyKey {
			case .dockTileRect:
				try Self.dockTileRect(container.decode(DockTileRect.self, forKey: onlyKey))
			case .dockEstimatedEdge:
				try Self.dockEstimatedEdge(container.decode(DockEstimatedEdge.self, forKey: onlyKey))
			case .dockRectAndEstimatedEdge:
				try Self.dockRectAndEstimatedEdge(container.decode(DockRectAndEstimatedEdge.self, forKey: onlyKey))
			case .requestAccessibilityAccess:
				try Self.requestAccessibilityAccess(container.decode(RequestAccessibilityAccess.self, forKey: onlyKey))
		}
	}

	public func encode(to encoder: any Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		switch self {
			case let .dockTileRect(value):
				try container.encode(value, forKey: .dockTileRect)
			case let .dockEstimatedEdge(value):
				try container.encode(value, forKey: .dockEstimatedEdge)
			case let .dockRectAndEstimatedEdge(value):
				try container.encode(value, forKey: .dockRectAndEstimatedEdge)
			case let .requestAccessibilityAccess(value):
				try container.encode(value, forKey: .requestAccessibilityAccess)
		}
	}
}

// MARK: -

public extension AccessibilityHelperMessage.Request {
	typealias Super = AccessibilityHelperMessage

	typealias DockTileRect = Super.DockTileRect.Request
	typealias DockEstimatedEdge = Super.DockEstimatedEdge.Request
	typealias DockRectAndEstimatedEdge = Super.DockRectAndEstimatedEdge.Request
	typealias RequestAccessibilityAccess = Super.RequestAccessibilityAccess.Request
}

// MARK: - Convenience

public extension AccessibilityHelperMessage.Request {
	static func dockTileRect(bundleURL: URL) -> Self {
		dockTileRect(
			DockTileRect(bundleURL: bundleURL)
		)
	}

	static func dockEstimatedEdge(screenIndex: Int) -> Self {
		dockEstimatedEdge(
			DockEstimatedEdge(screenIndex: screenIndex)
		)
	}

	static func dockRectAndEstimatedEdge(screenIndex: Int) -> Self {
		dockRectAndEstimatedEdge(
			DockRectAndEstimatedEdge(screenIndex: screenIndex)
		)
	}

	static func requestAccessibilityAccess() -> Self {
		requestAccessibilityAccess(
			RequestAccessibilityAccess()
		)
	}
}
