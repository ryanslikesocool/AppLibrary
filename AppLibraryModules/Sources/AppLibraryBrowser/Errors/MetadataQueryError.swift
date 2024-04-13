import Foundation

enum MetadataQueryError {
	case queryStartFailure
	case noSearchDirectories
}

// MARK: - LocalizedError

extension MetadataQueryError: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .queryStartFailure: "Failed to start query."
			case .noSearchDirectories: "No directories to search in."
		}
	}
}
