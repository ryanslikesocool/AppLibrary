// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryStorageModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryStorage", targets: ["AppLibraryStorage"]),
	],
	dependencies: [
		.package(path: "../AppLibraryCommonModules"),
	],
	targets: [
		.target(name: "AppLibraryStorage", dependencies: [
			.product(name: "AppLibraryCommon", package: "AppLibraryCommonModules"),
			.product(name: "AppLibraryCore", package: "AppLibraryCommonModules"),
		]),
	]
)
