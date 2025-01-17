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
		.library(name: "AppLibraryRuntimeModelViews", targets: ["AppLibraryRuntimeModelViews"]),

		.library(name: "AppLibraryXPCServer", targets: ["AppLibraryXPCServer"]),
		.library(name: "AppLibraryStorage", targets: ["AppLibraryStorage"]),

		.library(name: "AppLibraryCommon", targets: ["AppLibraryCommon"]),
		.library(name: "AppLibraryCommonViews", targets: ["AppLibraryCommonViews"]),
		.library(name: "AppLibraryResources", targets: ["AppLibraryResources"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/BundleToolbox.git", from: "0.0.5"),
		.package(url: "https://github.com/ryanslikesocool/LocalizationToolbox.git", from: "0.0.4"),
		.package(url: "https://github.com/ryanslikesocool/NSMetadataToolbox.git", from: "0.0.6"),
		.package(url: "https://github.com/ryanslikesocool/SFSymbolToolbox.git", from: "0.0.2"),

		.package(path: "../AppLibraryExtension"),
		.package(path: "../AppLibraryDockHelperModules"),
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

				"AppLibraryCommonViews",
				"AppLibrarySettingsWindow",
				"AppLibraryResources",
				"AppLibraryRuntimeModel",
				"AppLibraryXPCServer",
			]
		),

		.target(
			name: "AppLibraryAboutWindow",
			dependencies: [
				"AppLibraryCommon",
				"AppLibraryCommonViews",
				"AppLibraryResources",
			]
		),

		.target(
			name: "AppLibraryRuntimeModelViews",
			dependencies: [
				"AppLibraryRuntimeModel",
			]
		),

		.target(
			name: "AppLibraryRuntimeModel",
			dependencies: [
				"BundleToolbox",
				"NSMetadataToolbox",

				"AppLibraryStorage",
				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryXPCServer",
			dependencies: [
				.product(name: "AppLibraryExtensionServer", package: "AppLibraryExtension"),
				.product(name: "AppLibraryDockHelperShared", package: "AppLibraryDockHelperModules"),

				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryStorage",
			dependencies: [
				"NSMetadataToolbox",

				"AppLibraryCommon",
				"AppLibraryResources",
			]
		),

		.target(
			name: "AppLibraryResources",
			dependencies: [
				"BundleToolbox",
				"LocalizationToolbox",
				"SFSymbolToolbox",
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
				"AppLibraryResources",
			]
		),

		.target(
			name: "AppLibrarySettingsLayoutPane",
			dependencies: [
				"AppLibraryStorage",
				"AppLibraryResources",
			]
		),

		.target(
			name: "AppLibrarySettingsAppsPane",
			dependencies: [
				"AppLibraryStorage",
				"AppLibraryCommon",
				"AppLibraryCommonViews",
				"AppLibraryRuntimeModelViews",
				"AppLibraryRuntimeModel",
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
				"AppLibraryResources",
			]
		),

		.target(
			name: "AppLibraryCommon",
			dependencies: [
				"BundleToolbox",
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
