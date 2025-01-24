// swift-tools-version: 6.0

import PackageDescription

let package = Package(
	name: "AppLibraryAccessibilityHelperModules",
	defaultLocalization: "en",
	platforms: [
		.macOS(.v14),
	],
	products: [
		.library(name: "AppLibraryAccessibilityHelperClient", targets: ["AppLibraryAccessibilityHelperClient"]),
		.library(name: "AppLibraryAccessibilityHelperServer", targets: ["AppLibraryAccessibilityHelperServer"]),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/AXToolbox.git", from: "0.0.6"),

		.package(path: "../AppLibraryCore"),
		.package(path: "../AppLibraryExtension"),
	],
	targets: [
		.target(
			name: "AppLibraryAccessibilityHelperClient",
			dependencies: [
				"AXToolbox",

				.product(name: "AppLibraryExtensionClient", package: "AppLibraryExtension"),

				"AppLibraryAccessibilityHelperCommon",
			]
		),

			.target(
				name: "AppLibraryAccessibilityHelperServer",
				dependencies: [
					.product(name: "AppLibraryExtensionServer", package: "AppLibraryExtension"),

					"AppLibraryAccessibilityHelperCommon",
				]
			),

		.target(
			name: "AppLibraryAccessibilityHelperCommon",
			dependencies: [
				.product(name: "AppLibraryExtensionCommon", package: "AppLibraryExtension"),

				"AppLibraryCore",
			]
		),
	]
)
