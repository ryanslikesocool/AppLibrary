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

		.library(name: "AppLibraryBrowserWindow", targets: ["AppLibraryBrowserWindow"]),
		.library(name: "AppLibraryAboutWindow", targets: ["AppLibraryAboutWindow"]),
		.library(name: "AppLibrarySettingsWindow", targets: ["AppLibrarySettingsWindow"]),

		.library(name: "AppLibraryRuntimeModel", targets: ["AppLibraryRuntimeModel"]),
		.library(name: "AppLibraryStorage", targets: ["AppLibraryStorage"]),
		.library(name: "AppLibraryCommon", targets: ["AppLibraryCommon"]),
		.library(name: "AppLibraryCommonViews", targets: ["AppLibraryCommonViews"]),
		.library(name: "AppLibraryLocalization", targets: ["AppLibraryLocalization"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/LocalizationTable.git", from: "0.0.1"),
		.package(url: "https://github.com/ryanslikesocool/NSMetadataToolbox.git", from: "0.0.3"),
		.package(url: "https://github.com/ryanslikesocool/SwiftyAccessibility.git", from: "0.0.1"),
		.package(url: "https://github.com/ryanslikesocool/DictionaryPath.git", from: "0.0.1"),
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				"AppLibraryAboutWindow",
				"AppLibraryBrowserWindow",
				"AppLibrarySettingsWindow",
			]
		),

		.target(
			name: "AppLibraryBrowserWindow",
			dependencies: [
				"NSMetadataToolbox",
				"SwiftyAccessibility",
				"DictionaryPath",

				"AppLibraryCommonViews",
				"AppLibrarySettingsWindow",
				"AppLibraryLocalization",
				"AppLibraryRuntimeModel",
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
			]
		),

		.target(
			name: "AppLibraryRuntimeModel",
			dependencies: [
				"NSMetadataToolbox",

				"AppLibraryStorage",
			]
		),

		.target(
			name: "AppLibraryStorage",
			dependencies: [
				"NSMetadataToolbox",

				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryLocalization",
			dependencies: [
				"LocalizationTable",
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
				"AppLibraryLocalization",
			]
		),

		.target(
			name: "AppLibraryCommon"
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
