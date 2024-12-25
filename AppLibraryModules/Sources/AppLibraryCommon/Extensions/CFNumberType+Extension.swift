//import CoreFoundation
//
//extension CFNumberType: @retroactive CustomStringConvertible {
//	public var description: String {
//		switch self {
//			case .sInt8Type: "\(Self.self).sInt8"
//			case .sInt16Type: "\(Self.self).sInt16"
//			case .sInt32Type: "\(Self.self).sInt32"
//			case .sInt64Type: "\(Self.self).sInt64"
//			case .float32Type: "\(Self.self).float32"
//			case .float64Type: "\(Self.self).float64"
//			case .charType: "\(Self.self).char"
//			case .shortType: "\(Self.self).short"
//			case .intType: "\(Self.self).int"
//			case .longType: "\(Self.self).long"
//			case .longLongType: "\(Self.self).longLong"
//			case .floatType: "\(Self.self).float"
//			case .doubleType: "\(Self.self).double"
//			case .cfIndexType: "\(Self.self).cfIndex"
//			case .nsIntegerType: "\(Self.self).nsInteger"
//			case .cgFloatType: "\(Self.self).cgFloat"
//			@unknown default: "@unknown \(Self.self)"
//		}
//	}
//}

// NOTE: This extension is used for validating
// metadata attribute values in `NSMetadataToolbox`,
// and isn't needed for App Library.