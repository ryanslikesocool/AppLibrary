// swift-tools-version: 5.9

import PackageDescription

let package = Package(
	name: "AppLibraryModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v13),
	],
	products: [
		.library(
			name: "AppLibraryModules",
			targets: ["AppLibraryModules"]
		),
	],
	targets: [
		.target(
			name: "AppLibraryModules"
		),
	]
)
