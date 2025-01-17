import Foundation

enum LocalFileSerializationError: Error {
	case decodeFailure(Decodable.Type, Error)
	case encodeFailure(Encodable.Type, Error)
	case directoryValidationFailure(URL, Error)
	case dataReadFailure(URL, Error)
	case dataWriteFailure(URL, Error)
}
