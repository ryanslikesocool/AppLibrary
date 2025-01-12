extension Acknowledgement {
	enum Kind: String {
		case dependency
		case borrowedCode
//		case reference
	}
}

// MARK: - Sendable

extension Acknowledgement.Kind: Sendable { }

// MARK: - Decodable

extension Acknowledgement.Kind: Decodable { }