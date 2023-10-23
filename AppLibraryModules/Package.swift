// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "AppLibrary",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v13),
	],
	products: [
		.library(
			name: "AppLibrary",
			targets: ["AppLibrary"]
		),
	],
	targets: [
		.target(
			name: "AppLibrary",
			dependencies: [
				"AppLibraryBrowser",
				"AppLibraryAbout",
				"AppLibrarySettings",
			]
		),

		.target(
			name: "AppLibraryBrowser",
			dependencies: [
				"AppLibrarySettings",
			]
		),

		.target(
			name: "AppLibraryAbout",
			dependencies: [
				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibrarySettings",
			dependencies: ["AppLibraryCommon"]
		),

		.target(name: "AppLibraryCommon"),
	]
)
