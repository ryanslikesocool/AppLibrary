// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryCommonModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(
			name: "AppLibraryCommon",
			targets: ["AppLibraryCommon"]
		),
		.library(
			name: "AppLibraryCore",
			targets: ["AppLibraryCore"]
		),
	],
	targets: [
		.target(name: "AppLibraryCommon"),

		.target(name: "AppLibraryCore"),
	]
)
