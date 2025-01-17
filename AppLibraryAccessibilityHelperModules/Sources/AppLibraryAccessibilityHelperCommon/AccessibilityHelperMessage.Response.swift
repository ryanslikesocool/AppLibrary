import AppLibraryCore

public extension AccessibilityHelperMessage {
	enum Response {
		case dockTileRect(DockTileRect.Result)
		case dockEstimatedEdge(DockEstimatedEdge.Result)
		case dockRectAndEstimatedEdge(DockRectAndEstimatedEdge.Result)
		case requestAccessibilityAccess(RequestAccessibilityAccess.Result)
	}
}

// MARK: - Codable

extension AccessibilityHelperMessage.Response: Codable {
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
				try Self.dockTileRect(container.decode(DockTileRect.Result.self, forKey: onlyKey))
			case .dockEstimatedEdge:
				try Self.dockEstimatedEdge(container.decode(DockEstimatedEdge.Result.self, forKey: onlyKey))
			case .dockRectAndEstimatedEdge:
				try Self.dockRectAndEstimatedEdge(container.decode(DockRectAndEstimatedEdge.Result.self, forKey: onlyKey))
			case .requestAccessibilityAccess:
				try Self.requestAccessibilityAccess(container.decode(RequestAccessibilityAccess.Result.self, forKey: onlyKey))
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

public extension AccessibilityHelperMessage.Response {
	typealias Super = AccessibilityHelperMessage

	typealias DockTileRect = Super.DockTileRect.Response
	typealias DockEstimatedEdge = Super.DockEstimatedEdge.Response
	typealias DockRectAndEstimatedEdge = Super.DockRectAndEstimatedEdge.Response
	typealias RequestAccessibilityAccess = Super.RequestAccessibilityAccess.Response
}
