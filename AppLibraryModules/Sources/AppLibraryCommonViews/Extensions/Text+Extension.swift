import SwiftUI

public extension Text {
	@_disfavoredOverload
	init?(_ resource: LocalizedStringResource?) {
		guard let resource else {
			return nil
		}
		self.init(resource)
	}

	@_disfavoredOverload
	init?(verbatim: String?) {
		guard let verbatim else {
			return nil
		}
		self.init(verbatim: verbatim)
	}
}