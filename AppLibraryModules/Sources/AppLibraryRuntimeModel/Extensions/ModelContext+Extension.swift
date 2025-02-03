import Foundation
import SwiftData

public extension ModelContext {
//	func first<Subject>(
//		where predicate: Predicate<Subject>,
//		sortBy sortDescriptors: [SortDescriptor<Subject>] = []
//	) throws -> Subject? where
//		Subject: PersistentModel
//	{
//		let fetchDescriptor = FetchDescriptor<Subject>(
//			predicate: predicate,
//			sortBy: sortDescriptors
//		)
//		return try fetch(fetchDescriptor).first
//	}

	func count<Subject>(of subjectType: Subject.Type) throws -> Int where
		Subject: PersistentModel
	{
		let fetchDescriptor = FetchDescriptor<Subject>()
		return try fetchCount(fetchDescriptor)
	}

	func models<Subject>(ofType subjectType: Subject.Type) throws -> [Subject] where
		Subject: PersistentModel
	{
		let fetchDescriptor = FetchDescriptor<Subject>()
		return try fetch(fetchDescriptor)
	}

	func insert<Element>(
		contentsOf sequence: borrowing some Sequence<Element>
	) where
		Element: PersistentModel
	{
		sequence.forEach(insert(_:))
	}
}
