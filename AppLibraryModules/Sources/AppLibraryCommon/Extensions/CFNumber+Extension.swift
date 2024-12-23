import CoreFoundation

public extension CFNumber {
	var type: CFNumberType {
		CFNumberGetType(self)
	}
}