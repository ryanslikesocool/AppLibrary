// swift-tools-version: 6.1

import PackageDescription

let package = Package(
	name: "AppLibraryCore",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryCore", targets: ["AppLibraryCore"]),
	],
	targets: [
		.target(name: "AppLibraryCore"),
	]
)
