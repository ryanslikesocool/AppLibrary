// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(
			name: "AppLibraryModules",
			targets: ["AppLibrary"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/sindresorhus/ExceptionCatcher.git", from: "2.0.1"),
		.package(url: "https://github.com/orchetect/SettingsAccess.git", from: "2.0.0"),

		.package(url: "https://github.com/ryanslikesocool/LocalizationTable.git", branch: "main"),

		.package(path: "../AppLibraryCommonModules"),
		.package(path: "../AppLibraryStorageModules"),
		.package(path: "../AppLibraryAboutWindowModules"),
		.package(path: "../AppLibrarySettingsWindowModules"),
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				.product(name: "AppLibraryAboutWindow", package: "AppLibraryAboutWindowModules"),
				.product(name: "AppLibrarySettingsWindow", package: "AppLibrarySettingsWindowModules"),

				"AppLibraryBrowser",
			]
		),

		.target(
			name: "AppLibraryBrowser",
			dependencies: [
				"ExceptionCatcher",
				"SettingsAccess",

				"LocalizationTable",

				.product(name: "AppLibraryCommonViews", package: "AppLibraryCommonModules"),
				.product(name: "AppLibrarySettingsWindow", package: "AppLibrarySettingsWindowModules"),
			],
			swiftSettings: [
				.swiftLanguageMode(.v5),
			]
		),
	]
)
