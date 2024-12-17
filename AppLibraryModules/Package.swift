// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryModules", targets: ["AppLibrary"]),

		.library(name: "AppLibraryBrowser", targets: ["AppLibraryBrowser"]),
		.library(name: "AppLibraryAboutWindow", targets: ["AppLibraryAboutWindow"]),
		.library(name: "AppLibrarySettingsWindow", targets: ["AppLibrarySettingsWindow"]),

		.library(name: "AppLibraryStorage", targets: ["AppLibraryStorage"]),
		.library(name: "AppLibraryCommon", targets: ["AppLibraryCommon"]),
		.library(name: "AppLibraryCommonViews", targets: ["AppLibraryCommonViews"]),
		.library(name: "AppLibraryLocalization", targets: ["AppLibraryLocalization"]),
	],
	dependencies: [
		.package(url: "https://github.com/sindresorhus/ExceptionCatcher.git", from: "2.0.1"),
		.package(url: "https://github.com/orchetect/SettingsAccess.git", from: "2.0.0"),

		.package(url: "https://github.com/ryanslikesocool/LocalizationTable.git", from: "0.0.1"),
		.package(url: "https://github.com/ryanslikesocool/AsyncNSMetadataQuery.git", from: "0.0.1"),
		.package(url: "https://github.com/ryanslikesocool/SwiftyAccessibility.git", from: "0.0.1"),
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				"AppLibraryBrowser",
				"AppLibraryAboutWindow",
				"AppLibrarySettingsWindow",
			]
		),

		.target(
			name: "AppLibraryBrowser",
			dependencies: [
				"SettingsAccess",

				"AsyncNSMetadataQuery",
				"SwiftyAccessibility",

				"AppLibraryCommonViews",
				"AppLibrarySettingsWindow",
				"AppLibraryLocalization",
			],
			swiftSettings: [
				.swiftLanguageMode(.v5),
			]
		),

		.target(
			name: "AppLibraryAboutWindow",
			dependencies: [
				"AppLibraryCommon",
				"AppLibraryLocalization",
			],
			resources: [
				.process("Resources"),
			]
		),

		.target(
			name: "AppLibraryStorage",
			dependencies: [
				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryLocalization",
			dependencies: [
				"LocalizationTable",
			],
			resources: [
				.process("Resources"),
			]
		),
	]
		+ settingsWindowTargets
		+ commonTargets
)

// MARK: - Target Groups

var settingsWindowTargets: [Target] {
	[
		.target(
			name: "AppLibrarySettingsWindow",
			dependencies: [
				"SettingsAccess",

				"AppLibraryCommon",

				"AppLibrarySettingsGeneralPane",
				"AppLibrarySettingsLayoutPane",
				"AppLibrarySettingsAppsPane",
			]
		),

		.target(
			name: "AppLibrarySettingsGeneralPane",
			dependencies: [
				"AppLibraryStorage",
				"AppLibraryLocalization",
			]
		),

		.target(
			name: "AppLibrarySettingsLayoutPane",
			dependencies: [
				"AppLibraryStorage",
				"AppLibraryLocalization",
			]
		),

		.target(
			name: "AppLibrarySettingsAppsPane",
			dependencies: [
				"AppLibraryStorage",
				"AppLibraryCommon",
				"AppLibraryCommonViews",
			]
		),
	]
	.formatPaths(using: "Sources/SettingsWindow/%@")
}

var commonTargets: [Target] {
	[
		.target(
			name: "AppLibraryCommonViews",
			dependencies: [
				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryCommon",
			dependencies: [
				"ExceptionCatcher",
			]
		),
	]
}

// MARK: - Utility

extension [Target] {
	func formatPaths(using format: String) -> Self {
		map { target in
			target.formatPath(using: format)
			return target
		}
	}
}

extension Target {
	func formatPath(using format: String) {
		path = String(format: format, path ?? name)
	}
}
