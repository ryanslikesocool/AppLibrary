import CoreFoundation

// NOTE: This extension is used for validating
// metadata attribute values in `NSMetadataToolbox`,
// and isn't needed for App Library.

#if DEBUG
public extension CFNumber {
	var type: CFNumberType {
		CFNumberGetType(self)
	}
}
#endif