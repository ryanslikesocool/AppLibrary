// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryDockHelper",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryDockHelperModules", targets: ["AppLibraryDockHelper"]),
		.library(name: "AppLibraryDockHelperShared", targets: ["AppLibraryDockHelperShared"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/AXToolbox.git", from: "0.0.5"),

		.package(path: "../AppLibraryExtension"),
	],
	targets: [
		.target(
			name: "AppLibraryDockHelper",
			dependencies: [
				"AXToolbox",

				"AppLibraryDockHelperShared",
			]
		),

		.target(
			name: "AppLibraryDockHelperShared",
			dependencies: [
				.product(name: "AppLibraryExtensionClient", package: "AppLibraryExtension"),
			]
		),
	]
)
