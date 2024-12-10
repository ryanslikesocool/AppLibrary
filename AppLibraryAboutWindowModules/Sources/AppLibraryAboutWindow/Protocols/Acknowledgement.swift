import AppLibraryCommon
import Combine
import Foundation

protocol Acknowledgement: Sendable, Decodable {
	associatedtype Decoder: TopLevelDecoder where Decoder.Input == Data

	/// The location of the file containing the acknowledgements.
	static var fileURL: URL? { get }

	/// The top-level decoder used to decode the file at ``fileURL``.
	static var decoder: Decoder { get }

	/// The sort comparator used to sort the items in the UI.
	/// Leave this value `nil` to leave the items unsorted.
	static var sortComparator: (any SortComparator<Self>)? { get }

	@MainActor
	static var modelKeyPath: KeyPath<AboutWindowModel, [Self]> { get }
}

// MARK: - Default Implementation

extension Acknowledgement {
	static var sortComparator: (any SortComparator<Self>)? {
		nil
	}
}

extension Acknowledgement where
	Decoder == JSONDecoder
{
	static var decoder: JSONDecoder {
		JSONDecoder.shared
	}
}