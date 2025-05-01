// swift-tools-version: 6.1

import PackageDescription

let package = Package(
	name: "AppLibraryExtension",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryExtensionServer", targets: ["AppLibraryExtensionServer"]),
		.library(name: "AppLibraryExtensionClient", targets: ["AppLibraryExtensionClient"]),
		.library(name: "AppLibraryExtensionCommon", targets: ["AppLibraryExtensionCommon"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/XPCToolbox.git", from: "0.0.1"),

		.package(path: "../AppLibraryCore"),
	],
	targets: [
		.target(
			name: "AppLibraryExtensionServer",
			dependencies: [
				"XPCToolbox",

				"AppLibraryExtensionCommon",
			]
		),

		.target(
			name: "AppLibraryExtensionClient",
			dependencies: [
				"XPCToolbox",

				"AppLibraryExtensionCommon",
			]
		),

		.target(
			name: "AppLibraryExtensionCommon",
			dependencies: [
				"XPCToolbox",

				"AppLibraryCore",
			]
		),
	]
)
