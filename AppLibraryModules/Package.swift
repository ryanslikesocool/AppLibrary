// swift-tools-version: 5.10

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
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				"AppLibraryBrowser",
				"AppLibraryAbout",
				"AppLibrarySettingsViews",
			]
		),

		.target(
			name: "AppLibraryBrowser",
			dependencies: [
				"ExceptionCatcher",
				"SettingsAccess",

				"AppLibrarySettingsViews",
			]
		),

		.target(
			name: "AppLibraryAbout",
			dependencies: [
				"AppLibraryCommonViews",
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
				"AppLibraryStorage",
			]
		),

		.target(
			name: "AppLibraryStorage",
			dependencies: [
				"AppLibraryCommon",
			]
		),

		.target(name: "AppLibraryCommon"),
	]
)
