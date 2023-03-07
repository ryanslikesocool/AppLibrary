import LoveCore
import MoreViews
import SwiftUI

struct SearchBar: View {
	@FocusState private var focused: Bool

	@Binding var query: String

	var body: some View {
		TextField("􀊫 Search", text: $query)
			.focused($focused)
			.textFieldStyle(.roundedBorder)
			.controlSize(.large)
			.padding(4)
			.background(Material.regular, in: container)
			.compositingGroup()
			.shadow(radius: 4, y: 2)
			.padding(8)
			.onReceive(Notification.Name.activateSearch.publisher()) { _ in
				focused = true
			}
			.onSubmit { focused = false }
			.onExitCommand { focused = false }
	}

	private var container: some Shape { RoundedRectangle(cornerRadius: 12, style: .continuous) }
}
