import AppLibraryCommon
import Foundation

@MainActor
final class AboutWindowModel: ObservableObject {
	private(set) var dependencies: [Dependency]
	private(set) var contributors: [Contributor]

	init() {
		dependencies = []
		contributors = []
	}
}

// MARK: -

extension AboutWindowModel {
//	nonisolated func loadDependencyAcknowledgements() async {
//		let fileURL = Bundle.main.url(forResource: "Dependencies", withExtension: "json")
//		let sortComparator = KeyPathComparator<Dependency>(\.name)
//
//		await loadDefaultAcknowledgements(
//			ofType: Dependency.self,
//			from: fileURL,
//			to: { \.dependencies },
//			sortedUsing: sortComparator
//		)
//	}
//
//	nonisolated func loadContributorAcknowledgements() async {
//		let fileURL = Bundle.main.url(forResource: "Contributors", withExtension: "json")
//		let sortComparator = KeyPathComparator<Contributor>(\.name)
//
//		await loadDefaultAcknowledgements(
//			ofType: Contributor.self,
//			from: fileURL,
//			to: { \.contributors },
//			sortedUsing: sortComparator
//		)
//	}

	nonisolated func loadDefaultAcknowledgements<Target>(
		ofType targetType: Target.Type
	) async where
		Target: Acknowledgement
	{
		do {
			guard let url = Target.fileURL else {
				throw AcknowledgementLoadFailure.missingFile
			}
			let data = try Data(contentsOf: url)

			var acknowledgements = try Target.decoder.decode([Target].self, from: data)
			if let sortComparator = Target.sortComparator {
				acknowledgements.sort(using: sortComparator)
			}

			try await MainActor.run {
				// TODO: in case this cast always fails...
				// we may need to remove the `private(set)` accessibility modifier from the keyPath destination
				// and declare the `ReferenceWritableKeyPath<AboutWindowModel, [Target]>` directly in the `Acknowledgement` protocol.
				guard let destinationKeyPath = Target.modelKeyPath as? ReferenceWritableKeyPath<AboutWindowModel, [Target]> else {
					throw AcknowledgementLoadFailure.keyPathCastFailed
				}

				objectWillChange.send()
				self[keyPath: destinationKeyPath] = acknowledgements
			}
		} catch {
			assertionFailure("""
			Failed to load acknowledgements of type \(Target.self):
			- Error: \(error)
			""")
		}
	}

	private enum AcknowledgementLoadFailure: Swift.Error {
		case missingFile
		case keyPathCastFailed
	}

	// can't pass key path directly or use `@autoclosure`.  might be a Swift bug?
	// https://forums.swift.org/t/using-writablekeypath-with-actors/67550
	// https://github.com/hmlongco/Factory/issues/207
//	private nonisolated func loadDefaultAcknowledgements<Target>(
//		ofType targetType: Target.Type = Target.self,
//		from fileURL: URL?,
//		to targetKeyPath: @MainActor () -> ReferenceWritableKeyPath<AboutWindowModel, [Target]>,
//		sortedUsing sortComparator: some SortComparator<Target>
//	) async where
//		Target: Acknowledgement
//	{
//		do {
//			guard let url = fileURL else {
//				throw CocoaError(.fileReadNoSuchFile)
//			}
//			let data = try Data(contentsOf: url)
//			let acknowledgements = try Target.decoder.decode([Target].self, from: data)
//				.sorted(using: sortComparator)
//
//			await MainActor.run {
//				objectWillChange.send()
//				self[keyPath: targetKeyPath()] = acknowledgements
//			}
//		} catch {
//			assertionFailure("""
//			Failed to load acknowledgements of type \(Target.self):
//			- Error: \(error)
//			""")
//		}
//	}
}
