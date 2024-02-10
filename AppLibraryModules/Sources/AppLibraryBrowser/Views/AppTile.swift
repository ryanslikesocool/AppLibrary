import SwiftUI

struct AppTile: View {
	@Environment(\.appView) private var appView
	let application: Application

	var body: some View {
		Button(action: application.open) {
			switch appView {
				case .list: listView
				case .grid: gridView
			}
		}
		.contextMenu(menuItems: contextMenu)
		.id(application.id)
	}
}

// MARK: - Supporting Views

private extension AppTile {
	var icon: some View {
		Image(nsImage: application.getIcon())
			.resizable()
			.aspectRatio(contentMode: .fit)
			.frame(height: appView == .list ? Self.listIconSize : Self.gridIconSize)
	}

	var name: some View {
		Text(application.displayName)
	}

	@ViewBuilder func contextMenu() -> some View {
		Button("Open", action: application.open)
		Divider()
		Button("Hide", action: application.hide)
		Button("Show in Finder", action: application.showInFinder)
	}
}

// MARK: - List View

private extension AppTile {
	var listView: some View {
		HStack {
			icon
			name
			Spacer()
		}
		.contentShape(Rectangle())
	}
}

// MARK: - Grid View

private extension AppTile {
	var gridView: some View {
		VStack(alignment: .center, spacing: 4) {
			icon
			name
				.font(.subheadline)
				.truncationMode(.tail)
				.fixedSize(horizontal: true, vertical: false)
		}
		.contentShape(Rectangle())
		.multilineTextAlignment(.center)
	}
}

// MARK: - Constants

extension AppTile {
	static let listIconSize: Double = 56
	static let gridIconSize: Double = 48
}
