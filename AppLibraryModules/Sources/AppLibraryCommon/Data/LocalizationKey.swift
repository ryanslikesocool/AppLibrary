import LocalizationTable

public enum LocalizationKey<RawValue> where
	RawValue: LocalizationKeyProtocol
{ }

public extension LocalizationKey {
	enum AccessibilityRequest {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("AccessibilityRequest") }

		public static var action: Action.Type { Action.self }

		public static var title: RawValue { "TITLE" }
		public static var description: RawValue { "DESCRIPTION" }

		public enum Action {
			public static var allow: RawValue { "ACTION.ALLOW" }
			public static var deny: RawValue { "ACTION.DENY" }
		}
	}

	enum Acknowledgements {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("Acknowledgements") }

		public static var link: Link.Type { Link.self }
		public static var section: Section.Type { Section.self }

		public enum Link {
			public static var github: RawValue { "LINK.GITHUB" }
			public static var license: RawValue { "LINK.LICENSE" }
			public static var personal: RawValue { "LINK.PERSONAL" }
			public static var project: RawValue { "LINK.PROJECT" }
		}

		public enum Section {
			public static var title: RawValue { "SECTION.TITLE" }
		}
	}

	enum AdditionalApplicationGroups {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("AdditionalApplicationGroups") }

		public static var item: Item.Type { Item.self }
		public static var section: Section.Type { Section.self }

		public enum Item {
			public static var recentlyAdded: RecentlyAdded.Type { RecentlyAdded.self }
			public static var recentlyUpdated: RecentlyUpdated.Type { RecentlyUpdated.self }

			public enum RecentlyAdded {
				public static var label: RawValue { "ITEM.RECENTLY_ADDED.LABEL" }
				public static var description: RawValue { "ITEM.RECENTLY_ADDED.DESCRIPTION" }
			}

			public enum RecentlyUpdated {
				public static var label: RawValue { "ITEM.RECENTLY_UPDATED.LABEL" }
				public static var description: RawValue { "ITEM.RECENTLY_UPDATED.DESCRIPTION" }
			}
		}

		public enum Section {
			public static var title: RawValue { "SECTION.TITLE" }
			public static var description: RawValue { "SECTION.DESCRIPTION" }
		}
	}

	enum AppearancePicker {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("AppearancePicker") }

		public static var item: Item.Type { Item.self }

		public static var label: RawValue { "LABEL" }

		public enum Item {
			public static var light: RawValue { "ITEM.LIGHT" }
			public static var dark: RawValue { "ITEM.DARK" }
			public static var system: RawValue { "ITEM.SYSTEM" }
		}
	}

	enum ApplicationGroupCriteriaPicker {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("ApplicationGroupCriteriaPicker") }

		public static var item: Item.Type { Item.self }

		public static var label: RawValue { "LABEL" }

		public enum Item {
			public static var none: RawValue { "ITEM.NONE" }
			public static var category: RawValue { "ITEM.CATEGORY" }
		}
	}

	enum ApplicationHideFlagsList {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("ApplicationHideFlagsList") }

		public static var item: Item.Type { Item.self }
		public static var form: Form.Type { Form.self }
		public static var list: List.Type { List.self }

		public static var title: RawValue { "TITLE" }

		public enum Item {
			public static var format: Format.Type { Format.self }

			public static var browser: RawValue { "ITEM.BROWSER" }
			public static var search: RawValue { "ITEM.SEARCH" }

			public enum Format {
				public static func verb(_ argument: String) -> RawValue {
					"ITEM.FORMAT.VERB_\(argument)"
				}

				public static func adjective(_ argument: String) -> RawValue {
					"ITEM.FORMAT.ADJECTIVE_\(argument)"
				}
			}
		}

		public enum Form {
			public static var description: RawValue { "FORM.DESCRIPTION" }
		}

		public enum List {
			public static var emptyLabel: RawValue { "LIST.EMPTY_LABEL" }
			public static var description: RawValue { "LIST.DESCRIPTION" }
		}
	}

	enum ApplicationSearchScopesList {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("ApplicationSearchScopesList") }

		public static var item: Item.Type { Item.self }
		public static var addMenu: AddMenu.Type { AddMenu.self }
		public static var addDialog: AddDialog.Type { AddDialog.self }
		public static var form: Form.Type { Form.self }
		public static var list: List.Type { List.self }

		public static var title: RawValue { "TITLE" }

		public enum Item {
			public static var optionsLabel: RawValue { "ITEM.OPTIONS.LABEL" }
		}

		public enum AddMenu {
			public static var action: RawValue { "ADD_MENU.ACTION" }
			public static var label: RawValue { "ADD_MENU.LABEL" }
			public static var defaultSectionTitle: RawValue { "ADD_MENU.DEFAULT_SECTION.TITLE" }
		}

		public enum AddDialog {
			public static var confirm: RawValue { "ADD_DIALOG.CONFIRM" }
			public static var message: RawValue { "ADD_DIALOG.MESSAGE" }
		}

		public enum Form {
			public static var description: RawValue { "FORM.DESCRIPTION" }
		}

		public enum List {
			public static var description: RawValue { "LIST.DESCRIPTION" }
			public static var emptyLabel: RawValue { "LIST.EMPTY_LABEL" }
		}
	}

	enum BrowserError {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("BrowserError") }

		public static var noSearchScopes: NoSearchScopes.Type { NoSearchScopes.self }
		public static var noApplications: NoApplications.Type { NoApplications.self }
		public static var allApplicationsHidden: AllApplicationsHidden.Type { AllApplicationsHidden.self }

		public enum NoSearchScopes {
			public static var description: RawValue { "NO_SEARCH_SCOPES.DESCRIPTION" }
			public static var recoverySuggestion: RawValue { "NO_SEARCH_SCOPES.RECOVERY_SUGGESTION" }
		}

		public enum NoApplications {
			public static var description: RawValue { "NO_APPLICATIONS.DESCRIPTION" }
			public static var recoverySuggestion: RawValue { "NO_APPLICATIONS.RECOVERY_SUGGESTION" }
		}

		public enum AllApplicationsHidden {
			public static var description: RawValue { "ALL_APPLICATIONS_HIDDEN.DESCRIPTION" }
			public static var recoverySuggestion: RawValue { "ALL_APPLICATIONS_HIDDEN.RECOVERY_SUGGESTION" }
		}
	}

	enum Common {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("Common") }

		public static var action: Action.Type { Action.self }
		public static var browserWindow: BrowserWindow.Type { BrowserWindow.self }
		public static var link: Link.Type { Link.self }

		public enum Action {
			public static var cancel: RawValue { "ACTION.CANCEL" }
			public static var done: RawValue { "ACTION.DONE" }
			public static var refresh: RawValue { "ACTION.REFRESH" }
			public static var remove: RawValue { "ACTION.REMOVE" }
			public static var retry: RawValue { "ACTION.RETRY" }
			public static var reveal: RawValue { "ACTION.REVEAL" }
			public static var showInFinder: RawValue { "ACTION.SHOW_IN_FINDER" }
		}

		public enum BrowserWindow {
			public static var title: RawValue { "BROWSER_WINDOW.TITLE" }
		}

		public enum Link {
			public static var settings: RawValue { "LINK.SETTINGS" }
			public static var manage: RawValue { "LINK.MANAGE" }
		}
	}

	enum LibraryLayoutPicker {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("LibraryLayoutPicker") }

		public static var item: Item.Type { Item.self }

		public static var label: RawValue { "LABEL" }

		public enum Item {
			public static var list: RawValue { "ITEM.LIST" }
			public static var grid: RawValue { "ITEM.GRID" }
		}
	}

	enum SettingsWindow {
		public static var localizationTable: LocalizationTableResource { LocalizationTableResource("SettingsWindow") }

		public static var category: Category.Type { Category.self }

		public enum Category {
			public static var general: RawValue { "CATEGORY.GENERAL" }
			public static var layout: RawValue { "CATEGORY.LAYOUT" }
			public static var apps: RawValue { "CATEGORY.APPS" }
		}
	}
}
