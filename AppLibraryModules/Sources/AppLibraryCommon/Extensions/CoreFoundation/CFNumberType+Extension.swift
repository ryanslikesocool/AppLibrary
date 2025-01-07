import CoreFoundation

// MARK: - CustomStringConvertible

// NOTE: This extension is used for validating
// metadata attribute values in `NSMetadataToolbox`,
// and isn't needed for App Library.

#if DEBUG
extension CFNumberType: @retroactive CustomStringConvertible {
	public var description: String {
		switch self {
			case .sInt8Type: "sInt8"
			case .sInt16Type: "sInt16"
			case .sInt32Type: "sInt32"
			case .sInt64Type: "sInt64"
			case .float32Type: "float32"
			case .float64Type: "float64"
			case .charType: "char"
			case .shortType: "short"
			case .intType: "int"
			case .longType: "long"
			case .longLongType: "longLong"
			case .floatType: "float"
			case .doubleType: "double"
			case .cfIndexType: "cfIndex"
			case .nsIntegerType: "nsInteger"
			case .cgFloatType: "cgFloat"
			@unknown default: "@unknown \(Self.self)(rawValue: \(rawValue))"
		}
	}
}
#endif
