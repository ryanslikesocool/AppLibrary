// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibrarySettingsWindowModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(
			name: "AppLibrarySettingsWindow",
			targets: ["AppLibrarySettingsWindow"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/orchetect/SettingsAccess.git", from: "2.0.0"),

		.package(url: "https://github.com/ryanslikesocool/LocalizationTable.git", branch: "main"),

		.package(path: "../AppLibraryCommonModules"),
		.package(path: "../AppLibraryStorageModules"),
	],
	targets: [
		.target(
			name: "AppLibrarySettingsWindow",
			dependencies: [
				"SettingsAccess",

				.product(name: "AppLibraryCommon", package: "AppLibraryCommonModules"),

				"AppLibrarySettingsGeneralPane",
				"AppLibrarySettingsLayoutPane",
				"AppLibrarySettingsLocationPane",
				"AppLibrarySettingsAppsPane",
			]
		),

		.target(
			name: "AppLibrarySettingsGeneralPane",
			dependencies: [
				"LocalizationTable",

				.product(name: "AppLibraryStorage", package: "AppLibraryStorageModules"),
			]
		),

		.target(
			name: "AppLibrarySettingsLayoutPane",
			dependencies: [
				"LocalizationTable",

				.product(name: "AppLibraryStorage", package: "AppLibraryStorageModules"),
			]
		),

		.target(
			name: "AppLibrarySettingsLocationPane",
			dependencies: [
				"LocalizationTable",
				
				.product(name: "AppLibraryStorage", package: "AppLibraryStorageModules"),
				.product(name: "AppLibraryCommon", package: "AppLibraryCommonModules"),
				.product(name: "AppLibraryCommonViews", package: "AppLibraryCommonModules"),
			]
		),

		.target(
			name: "AppLibrarySettingsAppsPane",
			dependencies: [
				"LocalizationTable",

				.product(name: "AppLibraryStorage", package: "AppLibraryStorageModules"),
				.product(name: "AppLibraryCommon", package: "AppLibraryCommonModules"),
				.product(name: "AppLibraryCommonViews", package: "AppLibraryCommonModules"),
			]
		),
	]
)
