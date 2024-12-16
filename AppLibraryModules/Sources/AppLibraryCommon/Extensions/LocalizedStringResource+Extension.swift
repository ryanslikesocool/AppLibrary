import Foundation
import LocalizationTable

public extension LocalizedStringResource {
	static let accessibilityRequest = AccessibilityRequest.self
	static let acknowledgements = Acknowledgements.self
	static let additionalApplicationGroups = AdditionalApplicationGroups.self
	static let appearancePicker = AppearancePicker.self
	static let applicationGroupCriteriaPicker = ApplicationGroupCriteriaPicker.self
	static let applicationHideFlagsList = ApplicationHideFlagsList.self
	static let applicationSearchScopesList = ApplicationSearchScopesList.self
	static let browserError = BrowserError.self
	static let common = Common.self
	static let libraryLayoutPicker = LibraryLayoutPicker.self
	static let settingsWindow = SettingsWindow.self
}

public extension LocalizedStringResource {
	enum AccessibilityRequest {
		public static let localizationTable = LocalizationTableResource("AccessibilityRequest")

		public static let action = Action.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)
		public static let description = LocalizedStringResource("DESCRIPTION", table: localizationTable)

		public enum Action {
			public static let allow = LocalizedStringResource("ACTION.ALLOW", table: localizationTable)
			public static let deny = LocalizedStringResource("ACTION.DENY", table: localizationTable)
		}
	}

	enum Acknowledgements {
		public static let localizationTable = LocalizationTableResource("Acknowledgements")

		public static let link = Link.self
		public static let section = Section.self

		public enum Link {
			public static let github = LocalizedStringResource("LINK.GITHUB", table: localizationTable)
			public static let license = LocalizedStringResource("LINK.LICENSE", table: localizationTable)
			public static let personal = LocalizedStringResource("LINK.PERSONAL", table: localizationTable)
			public static let project = LocalizedStringResource("LINK.PROJECT", table: localizationTable)
		}

		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
		}
	}

	enum AdditionalApplicationGroups {
		public static let localizationTable = LocalizationTableResource("AdditionalApplicationGroups")

		public static let item: Item.Type = Item.self
		public static let section: Section.Type = Section.self

		public enum Item {
			public static let recentlyAdded = RecentlyAdded.self
			public static let recentlyUpdated = RecentlyUpdated.self

			public enum RecentlyAdded {
				public static let label = LocalizedStringResource("ITEM.RECENTLY_ADDED.LABEL", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_ADDED.DESCRIPTION", table: localizationTable)
			}

			public enum RecentlyUpdated {
				public static let label = LocalizedStringResource("ITEM.RECENTLY_UPDATED.LABEL", table: localizationTable)
				public static let description = LocalizedStringResource("ITEM.RECENTLY_UPDATED.DESCRIPTION", table: localizationTable)
			}
		}

		public enum Section {
			public static let title = LocalizedStringResource("SECTION.TITLE", table: localizationTable)
			public static let description = LocalizedStringResource("SECTION.DESCRIPTION", table: localizationTable)
		}
	}

	enum AppearancePicker {
		public static let localizationTable = LocalizationTableResource("AppearancePicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public enum Item {
			public static let light = LocalizedStringResource("ITEM.LIGHT", table: localizationTable)
			public static let dark = LocalizedStringResource("ITEM.DARK", table: localizationTable)
			public static let system = LocalizedStringResource("ITEM.SYSTEM", table: localizationTable)
		}
	}

	enum ApplicationGroupCriteriaPicker {
		public static let localizationTable = LocalizationTableResource("ApplicationGroupCriteriaPicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public enum Item {
			public static let none = LocalizedStringResource("ITEM.NONE", table: localizationTable)
			public static let category = LocalizedStringResource("ITEM.CATEGORY", table: localizationTable)
		}
	}

	enum ApplicationHideFlagsList {
		public static let localizationTable = LocalizationTableResource("ApplicationHideFlagsList")

		public static let item = Item.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public enum Item {
			public static let format = Format.self

			public static let browser = LocalizedStringResource("ITEM.BROWSER", table: localizationTable)
			public static let search = LocalizedStringResource("ITEM.SEARCH", table: localizationTable)

			public enum Format {
				public static func verb(_ argument: String) -> LocalizedStringResource {
					LocalizedStringResource("ITEM.FORMAT.VERB_\(argument)", table: localizationTable)
				}

				public static func adjective(_ argument: String) -> LocalizedStringResource {
					LocalizedStringResource("ITEM.FORMAT.ADJECTIVE_\(argument)", table: localizationTable)
				}
			}
		}

		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		public enum List {
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
			public static let description = LocalizedStringResource("LIST.DESCRIPTION", table: localizationTable)
		}
	}

	enum ApplicationSearchScopesList {
		public static let localizationTable = LocalizationTableResource("ApplicationSearchScopesList")

		public static let item = Item.self
		public static let addMenu = AddMenu.self
		public static let addDialog = AddDialog.self
		public static let form = Form.self
		public static let list = List.self

		public static let title = LocalizedStringResource("TITLE", table: localizationTable)

		public enum Item {
			public static let optionsLabel = LocalizedStringResource("ITEM.OPTIONS.LABEL", table: localizationTable)
		}

		public enum AddMenu {
			public static let action = LocalizedStringResource("ADD_MENU.ACTION", table: localizationTable)
			public static let label = LocalizedStringResource("ADD_MENU.LABEL", table: localizationTable)
			public static let defaultSectionTitle = LocalizedStringResource("ADD_MENU.DEFAULT_SECTION.TITLE", table: localizationTable)
		}

		public enum AddDialog {
			public static let confirm = LocalizedStringResource("ADD_DIALOG.CONFIRM", table: localizationTable)
			public static let message = LocalizedStringResource("ADD_DIALOG.MESSAGE", table: localizationTable)
		}

		public enum Form {
			public static let description = LocalizedStringResource("FORM.DESCRIPTION", table: localizationTable)
		}

		public enum List {
			public static let description = LocalizedStringResource("LIST.DESCRIPTION", table: localizationTable)
			public static let emptyLabel = LocalizedStringResource("LIST.EMPTY_LABEL", table: localizationTable)
		}
	}

	enum BrowserError {
		public static let localizationTable = LocalizationTableResource("BrowserError")

		public static let noSearchScopes = NoSearchScopes.self
		public static let noApplications = NoApplications.self
		public static let allApplicationsHidden = AllApplicationsHidden.self

		public enum NoSearchScopes {
			public static let description = LocalizedStringResource("NO_SEARCH_SCOPES.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_SEARCH_SCOPES.RECOVERY_SUGGESTION", table: localizationTable)
		}

		public enum NoApplications {
			public static let description = LocalizedStringResource("NO_APPLICATIONS.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("NO_APPLICATIONS.RECOVERY_SUGGESTION", table: localizationTable)
		}

		public enum AllApplicationsHidden {
			public static let description = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.DESCRIPTION", table: localizationTable)
			public static let recoverySuggestion = LocalizedStringResource("ALL_APPLICATIONS_HIDDEN.RECOVERY_SUGGESTION", table: localizationTable)
		}
	}

	enum Common {
		public static let localizationTable = LocalizationTableResource("Common")

		public static let action = Action.self
		public static let browserWindow = BrowserWindow.self
		public static let link = Link.self

		public enum Action {
			public static let cancel = LocalizedStringResource("ACTION.CANCEL", table: localizationTable)
			public static let done = LocalizedStringResource("ACTION.DONE", table: localizationTable)
			public static let refresh = LocalizedStringResource("ACTION.REFRESH", table: localizationTable)
			public static let remove = LocalizedStringResource("ACTION.REMOVE", table: localizationTable)
			public static let retry = LocalizedStringResource("ACTION.RETRY", table: localizationTable)
			public static let reveal = LocalizedStringResource("ACTION.REVEAL", table: localizationTable)
			public static let showInFinder = LocalizedStringResource("ACTION.SHOW_IN_FINDER", table: localizationTable)
		}

		public enum BrowserWindow {
			public static let title = LocalizedStringResource("BROWSER_WINDOW.TITLE", table: localizationTable)
		}

		public enum Link {
			public static let settings = LocalizedStringResource("LINK.SETTINGS", table: localizationTable)
			public static let manage = LocalizedStringResource("LINK.MANAGE", table: localizationTable)
		}
	}

	enum LibraryLayoutPicker {
		public static let localizationTable = LocalizationTableResource("LibraryLayoutPicker")

		public static let item = Item.self

		public static let label = LocalizedStringResource("LABEL", table: localizationTable)

		public enum Item {
			public static let list = LocalizedStringResource("ITEM.LIST", table: localizationTable)
			public static let grid = LocalizedStringResource("ITEM.GRID", table: localizationTable)
		}
	}

	enum SettingsWindow {
		public static let localizationTable = LocalizationTableResource("SettingsWindow")

		public static let category = Category.self

		public enum Category {
			public static let general = LocalizedStringResource("CATEGORY.GENERAL", table: localizationTable)
			public static let layout = LocalizedStringResource("CATEGORY.LAYOUT", table: localizationTable)
			public static let apps = LocalizedStringResource("CATEGORY.APPS", table: localizationTable)
		}
	}
}
