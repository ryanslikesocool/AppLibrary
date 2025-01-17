// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryAccessibilityHelperModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryAccessibilityHelperModules", targets: ["AppLibraryAccessibilityHelper"]),
		.library(name: "AppLibraryAccessibilityHelperShared", targets: ["AppLibraryAccessibilityHelperShared"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/AXToolbox.git", from: "0.0.5"),

		.package(path: "../AppLibraryCore"),
		.package(path: "../AppLibraryExtension"),
	],
	targets: [
		.target(
			name: "AppLibraryAccessibilityHelper",
			dependencies: [
				"AXToolbox",

				"AppLibraryAccessibilityHelperShared",
			]
		),

		.target(
			name: "AppLibraryAccessibilityHelperShared",
			dependencies: [
				.product(name: "AppLibraryExtensionClient", package: "AppLibraryExtension"),
				"AppLibraryCore",
			]
		),
	]
)
