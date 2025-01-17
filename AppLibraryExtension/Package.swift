// swift-tools-version: 6.0

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
	],
	targets: [
		.target(
			name: "AppLibraryExtensionServer",
			dependencies: [
				"AppLibraryExtensionCommon",
			]
		),

		.target(
			name: "AppLibraryExtensionClient",
			dependencies: [
				"AppLibraryExtensionCommon",
			]
		),

		.target(name: "AppLibraryExtensionCommon"),
	]
)
