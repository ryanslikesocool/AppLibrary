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

		.package(path: "../AppLibraryCommonModules"),
		.package(path: "../AppLibraryStorageModules"),
		.package(path: "../AppLibraryAboutWindowModules"),
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				"AppLibraryBrowser",
				"AppLibrarySettingsViews",
				.product(name: "AppLibraryAboutWindow", package: "AppLibraryAboutWindowModules"),
			]
		),

		.target(
			name: "AppLibraryBrowser",
			dependencies: [
				"ExceptionCatcher",
				"SettingsAccess",

				"AppLibrarySettingsViews",
			],
			swiftSettings: [
				.swiftLanguageMode(.v5),
			]
		),

		.target(
			name: "AppLibrarySettingsViews",
			dependencies: [
				"AppLibraryCommonViews",
			]
		),

		// MARK: -

		.target(
			name: "AppLibraryCommonViews",
			dependencies: [
				.product(name: "AppLibraryStorage", package: "AppLibraryStorageModules"),
			]
		),
	]
)
