import AppIntents
import AppLibraryCommon
import AppLibraryResources
import Foundation
import SFSymbolToolbox
import SwiftUI

public enum SettingsCategory: String {
	case general
	case layout
	case apps
}

// MARK: - Sendable

extension SettingsCategory: Sendable { }

// MARK: - Equatable

extension SettingsCategory: Equatable { }

// MARK: - Hashable

extension SettingsCategory: Hashable { }

// MARK: - Identifiable

extension SettingsCategory: Identifiable {
	public var id: RawValue { rawValue }
}

// MARK: - CaseIterable

extension SettingsCategory: CaseIterable { }

// MARK: - CaseDisplayRepresentable

extension SettingsCategory: CaseDisplayRepresentable {
	public static let caseDisplayRepresentations: [Self : DisplayRepresentation] = [
		.general: DisplayRepresentation(
			title: LocalizedStringResource("CATEGORY.GENERAL.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .gearShape),
		),

		.layout: DisplayRepresentation(
			title: LocalizedStringResource("CATEGORY.LAYOUT.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .square_grid_3x3),
		),

		.apps: DisplayRepresentation(
			title: LocalizedStringResource("CATEGORY.APPS.TITLE", table: Self.localizationTable),
			image: DisplayRepresentation.Image(systemName: .app),
		),
	]
}

// MARK: - CustomLabelConvertible

extension SettingsCategory: CustomLabelConvertible {
	public var label: Label<Text, Image> {
		Label {
			Text(localizedStringResource)
		} icon: {
//			Self.caseDisplayRepresentations[self]!.image
			Image(systemName: systemSymbolName)
		}
	}
}

// MARK: - Constants

private extension SettingsCategory {
	static let localizationTable = "SettingsWindow"
}

// MARK: -

public extension SettingsCategory {
//	@available(*, deprecated)
	var systemSymbolName: SystemSymbolName {
		switch self {
			case .general: .gearShape
			case .layout: .square_grid_3x3
			case .apps: .app
		}
	}
}
