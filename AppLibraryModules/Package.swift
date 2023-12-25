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
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/SerializationKit", branch: "main"),
		.package(url: "https://github.com/sindresorhus/ExceptionCatcher.git", from: "2.0.1"),
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
				"ExceptionCatcher",

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
			dependencies: [
				"SerializationKit",

				"AppLibraryCommon",
			]
		),

		.target(name: "AppLibraryCommon"),
	]
)
