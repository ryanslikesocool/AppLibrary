// swift-tools-version: 5.7

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
			targets: [
				"ALSettings",
			]
		),
	],
	dependencies: [
		.package(url: "https://github.com/ryanslikesocool/LoveCore.git", branch: "main"),
		.package(url: "https://github.com/ryanslikesocool/MoreViews.git", branch: "main"),
		.package(url: "https://github.com/ryanslikesocool/SerializationKit.git", branch: "main"),
	],
	targets: [
		.target(
			name: "ALSettings",
			dependencies: [
				"LoveCore",
				"MoreViews",
				"SerializationKit",
			]
		),
	]
)
