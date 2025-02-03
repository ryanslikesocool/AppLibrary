import AppLibraryCommon
import AppLibraryStorage
import Combine
import Foundation
import OSLog
import SwiftData

@MainActor
public final class ApplicationCache: Observable {
	public let modelContainer: ModelContainer

	@Published public internal(set) var state: ApplicationCacheState

	public init() {
		modelContainer = try! ModelContainer(
			for: ApplicationModel.self, ApplicationInstance.self,
			configurations: ModelConfiguration(isStoredInMemoryOnly: true)
		)
		state = .idle
	}
}

// MARK: - Constants

extension ApplicationCache {
	nonisolated static let logger: Logger = Logger(category: ApplicationCache.self)

	/// The shared application cache instance.
	public static let shared: ApplicationCache = ApplicationCache()
}

// MARK: -

extension ApplicationCache {
	func find(withBundleIdentifier bundleIdentifier: String) -> ApplicationModel? {
		let predicate = #Predicate<ApplicationModel> { existingModel in
			existingModel.bundleIdentifier == bundleIdentifier
		}
		let fetchDescriptor = FetchDescriptor<ApplicationModel>(predicate: predicate)

		// `ApplicationModel.bundleIdentifier` is marked as unique
		// So only zero or one instances should ever exist at a time.

		let fetchResult = try? modelContainer.mainContext.fetch(fetchDescriptor)
		return fetchResult?.first
	}

	func find(withIdentifier modelIdentifier: borrowing ApplicationModelIdentifier) -> ApplicationModel? {
		find(withBundleIdentifier: modelIdentifier.bundleIdentifier)
	}

	func insert(_ applicationModel: ApplicationModel) {
		if let existingApplicationModel = find(withBundleIdentifier: applicationModel.bundleIdentifier) {
			existingApplicationModel.formUnion(applicationModel)
		} else {
			modelContainer.mainContext.insert(applicationModel)
		}
	}

//	func insert(_ applicationModels: Set<ApplicationModel>) {
//		do {
//			try modelContainer.mainContext.transaction {
////				applicationModels.forEach(insert(_:)) // TODO: Figure out why this wants to `throw`
//
//				for applicationModel in applicationModels {
//					insert(applicationModel)
//				}
//			}
//		} catch {
//			Logger.module.error("""
//			Failed to insert models:
//			- Error: \(error)
//			""")
//		}
//	}

	func replaceStorage(with applicationModels: some Sequence<ApplicationModel>) {
		// TODO: Improve updating
		// - Remove old models
		// - Update existing models
		// - Add new models

		do {
			// Do a bunch of the operations at once.
			try modelContainer.mainContext.transaction {

				// NOTE: We can't use `modelContainer.deleteAllData()` or `modelContainer.erase()`
				// because the app crashes when trying to insert entities.
				// (I think it might delete the entity descriptions.)
				// So instead, we delete all models with matching types.
				try modelContainer.mainContext.delete(model: ApplicationModel.self)
//				try modelContainer.mainContext.delete(model: ApplicationInstance.self) // Deleting all `ApplicationModel`s should cascade.

				for applicationModel in applicationModels {
					modelContainer.mainContext.insert(applicationModel)
					for instance in applicationModel.instances {
						modelContainer.mainContext.insert(instance)
					}
				}
			}
		} catch {
			Logger.module.error("""
			Failed to replace storage:
			- Error: \(error)
			""")
		}
	}
}
