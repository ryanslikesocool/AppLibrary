import Foundation

public enum CommonError {
	case castFailure(source: Any.Type, destination: Any.Type)
	case unexpectedNil
}

// MARK: - LocalizedError

extension CommonError: LocalizedError {
	public var errorDescription: String? {
		switch self {
			case let .castFailure(source, destination): "Failed to cast an object from type `\(source)` to type `\(destination)`."
			case .unexpectedNil: "Expected a non-nil value."
		}
	}
}

// MARK: -

public extension CommonError {
	static func castFailure(from source: Any.Type, to destination: Any.Type) -> Self {
		castFailure(source: source, destination: destination)
	}

	static func castFailure(from object: Any?, to destination: Any.Type) -> Self {
		castFailure(source: type(of: object), destination: destination)
	}
}
