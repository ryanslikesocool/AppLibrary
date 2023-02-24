import LoveCore
import MoreViews
import SwiftUI

struct DockView: View {
	var body: some View {
		Image(nsImage: AppInformation.appIcon)
			.onTapGesture {
				print("yoyyyyy")
			}
	}
}
