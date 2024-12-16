public extension Sequence where
	Element == Application
{
	func standardReduction() -> [ApplicationIdentifier: Application] {
		reduce(
			into: [ApplicationIdentifier: Application]()
		) { partialResult, element in
			if var existingApp = partialResult[element.id] {
				// already exists.  resolve conflict
				var element = element
				if
					let existingCreationDate = existingApp.creationDate,
					let newCreationDate = element.creationDate,
					newCreationDate < existingCreationDate
				{
					partialResult[element.id] = element
				}
			} else {
				// doesn't exist.  push
				partialResult[element.id] = element
			}
		}
	}
}
