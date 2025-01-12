import AppLibraryCommon
import Combine
import Foundation

protocol CreditProtocol: Sendable, Decodable {
	associatedtype TopLevelDecoder: Combine.TopLevelDecoder where TopLevelDecoder.Input == Data

	/// The location of the file containing the acknowledgements.
	static var fileURL: URL? { get }

	/// The top-level decoder used to decode the file at ``fileURL``.
	static var topLevelDecoder: TopLevelDecoder { get }

	/// The sort comparator used to sort the items in the UI.
	/// Leave this value `nil` to leave the items unsorted.
	static var sortComparator: (any SortComparator<Self>)? { get }

	@MainActor
	static var modelKeyPath: KeyPath<AboutWindowModel, [Self]> { get }
}

// MARK: - Default Implementation

extension CreditProtocol {
	static var sortComparator: (any SortComparator<Self>)? {
		nil
	}
}

extension CreditProtocol where
	TopLevelDecoder == JSONDecoder
{
	static var topLevelDecoder: JSONDecoder {
		JSONDecoder.shared
	}
}
