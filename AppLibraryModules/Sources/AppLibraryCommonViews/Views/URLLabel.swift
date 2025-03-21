import AppLibraryCommon
import SwiftUI

public struct URLLabel<Format>: View where
	Format: FormatStyle,
	Format.FormatInput == URL,
	Format.FormatOutput == String
{
	private let url: URL
	private let format: Format

	public init(
		_ url: URL,
		format: Format = .abbreviatingTilde
	) {
		self.url = url
		self.format = format
	}

	public var body: some View {
		Text(url, format: format)
	}
}
