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
	targets: [
		.target(name: "AppLibraryAboutWindow"),
	]
)
