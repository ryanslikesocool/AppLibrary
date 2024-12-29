public extension Dictionary where
	Self: Encodable,
	Key: RawRepresentable,
	Key.RawValue == String
{
	typealias EncodableRepresentation = [Key.RawValue: Value]

	var encodableRepresentation: EncodableRepresentation {
		EncodableRepresentation(uniqueKeysWithValues: map { key, value in
			(key.rawValue, value)
		})
	}
}

public extension Dictionary where
	Self: Decodable,
	Key: RawRepresentable,
	Key.RawValue == String
{
	typealias DecodableRepresentation = [Key.RawValue: Value]

	init(decodableRepresentation: DecodableRepresentation) {
		self.init(uniqueKeysWithValues: decodableRepresentation.compactMap { keyRawValue, value in
			guard let key = Key(rawValue: keyRawValue) else {
				return nil
			}
			return (key, value)
		})
	}
}
