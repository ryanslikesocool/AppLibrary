public protocol SearchModel: FilterProtocol {
	associatedtype Subject
	associatedtype Token: SearchToken = DefaultSearchToken<Subject> where
		Token.Subject == Subject

	var query: String { get set }
	var tokens: [Token] { get set }

	var isEmpty: Bool { get }

	mutating func clear()
}

// MARK: - Default Implementation

public extension SearchModel {
	var isEmpty: Bool {
		query.isEmpty && tokens.isEmpty
	}

	mutating func clear() {
		query = ""
		tokens.removeAll()
	}
}

public extension SearchModel where
	Token == DefaultSearchToken<Subject>
{
	var tokens: [Token] {
		get { [Token]() }
		set { }
	}
}
