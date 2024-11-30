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
			name: "AppLibraryCommonViews",
			targets: ["AppLibraryCommonViews"]
		),
		.library(
			name: "AppLibraryCommon",
			targets: ["AppLibraryCommon"]
		),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/LocalizationTable.git", branch: "main"),
	],
	targets: [
		.target(
			name: "AppLibraryCommonViews",
			dependencies: [
				"AppLibraryCommon",
			]
		),

		.target(
			name: "AppLibraryCommon",
			dependencies: [
				"LocalizationTable",
			]
		),
	]
)
