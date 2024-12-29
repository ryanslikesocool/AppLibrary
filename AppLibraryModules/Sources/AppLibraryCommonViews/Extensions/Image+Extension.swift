import SwiftUI

public extension Image {
	init(systemName: SFSymbol) {
		self.init(systemName: systemName.rawValue)
	}

	init(_ name: CustomSFSymbol, bundle: Bundle? = nil) {
		self.init(name.rawValue, bundle: bundle)
	}
}