import AppLibraryResources
import AppLibraryStorage
import LocalizationToolbox
import SwiftUI

struct OpenAtLoginToggle: View {
	@Storage(general: \.openAtLogin) private var openAtLogin

	public init() { }

	public var body: some View {
		Toggle(
			.openAtLoginToggle.label,
			isOn: $openAtLogin.isEnabled
		)
	}
}
