// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryAboutWindowModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(
			name: "AppLibraryAboutWindow",
			targets: ["AppLibraryAboutWindow"]
		),
	],
	dependencies: [
		.package(path: "../AppLibraryCommonModules"),
	],
	targets: [
		.target(
			name: "AppLibraryAboutWindow",
			dependencies: [
				.product(name: "AppLibraryCommon", package: "AppLibraryCommonModules"),
			]
		),
	]
)
