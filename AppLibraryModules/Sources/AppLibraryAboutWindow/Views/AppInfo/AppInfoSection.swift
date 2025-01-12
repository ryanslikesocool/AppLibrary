import BundleToolbox
import SwiftUI

struct AppInfoSection: View {
	public init() { }

	public var body: some View {
		VStack {
			AppIcon()
			AppName()
			AppVersion()
		}
	}
}
