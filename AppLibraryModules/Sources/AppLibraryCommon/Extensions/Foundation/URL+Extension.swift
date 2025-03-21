import AppKit
import Foundation

// MARK: - Constants

public extension URL {
	/// The applications directory for the current user.
	///
	/// This URL is the equivalent of the shell value `~/Applications`.
	///
	/// - Complexity: O(1)
	static var userApplicationDirectory: Self {
		// I don't know if localization is necessary,
		// but I assume(?) the same name is used for
		// `~/Applications` and `/Applications`
		// in most languages.

		let result = Self.homeDirectory
			.appending(
				component: Self.applicationDirectory.lastPathComponent,
				directoryHint: .isDirectory
			)

		return result
	}
}

// MARK: -

public extension URL {
	static var unsandboxedHomeDirectory: Self {
		// The first 3 path components for anything residing in the home directory should always be
		// `/`, `Users`, `<current_user>`,
		// sandboxed or not.

		let path = Self.homeDirectory
			.pathComponents[0 ..< 3]
			.joined(separator: .urlComponentSeparator)

		return URL(filePath: path, directoryHint: .isDirectory)
	}

	/// A new string that replaces the current home directory portion of the current path with a tilde (~) character.
	///
	/// A new string based on the current string object.
	/// If the new string specifies a file in the current home directory, the home directory portion of the path is replaced with a tilde (~) character.
	/// If the string does not specify a file in the current home directory, this method returns a new string object whose path is unchanged from the path in the current string.
	///
	/// Note that this method only works with file paths.
	/// It does not work for string representations of URLs.
	var abbreviatingWithTildeInPath: String {
		let pathComponents = self.pathComponents

		let homeDirectoryComponents = URL.homeDirectory.pathComponents
		let unsandboxedHomeDirectoryComponents = URL.unsandboxedHomeDirectory.pathComponents

		return if pathComponents.starts(with: homeDirectoryComponents) {
			// Sandboxed apps processing a sandboxed URL take this branch.
			// Unsandboxed apps processing an unsandboxed URL take this branch.
			formatComponentsInHomeDirectory(
				pathComponents,
				dropFirst: homeDirectoryComponents.count
			)
		} else if pathComponents.starts(with: unsandboxedHomeDirectoryComponents) {
			// Sandboxed apps processing an unsandboxed URL take this branch.
			formatComponentsInHomeDirectory(
				pathComponents,
				dropFirst: unsandboxedHomeDirectoryComponents.count
			)
		} else {
			// The `NSString`  implementation does not support sandboxed apps, but we can use it as a fallback.
			(path(percentEncoded: false) as NSString)
				.abbreviatingWithTildeInPath
		}

		func formatComponentsInHomeDirectory(
			_ components: some Sequence<String>,
			dropFirst dropPrefixCount: Int
		) -> String {
			joinComponents(
				["~"]
					+ components
					.dropFirst(dropPrefixCount)
			)
		}

		func joinComponents(_ components: some Sequence<String>) -> String {
			components
				.joined(separator: .urlComponentSeparator)
		}
	}

	/// A new string made by expanding the initial component of the receiver to its full path value.
	///
	/// A new string made by expanding the initial component of the receiver, if it begins with “~” or “~user”, to its full path value.
	/// Returns a new string matching the receiver if the receiver’s initial component can’t be expanded.
	///
	/// Note that this method only works with file paths.
	/// It does not work for string representations of URLs.
	var expandingTildeInPath: String {
		(path(percentEncoded: false) as NSString).expandingTildeInPath
	}
}

// MARK: - Show in Finder

public extension URL {
	/// Activates the Finder, and opens a window selecting the specified file.
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting([self])
	}
}

public extension Sequence where
	Element == URL
{
	/// Activates the Finder, and opens one or more windows selecting the specified files.
	func showInFinder() {
		NSWorkspace.shared.activateFileViewerSelecting(Array(self))
	}
}
