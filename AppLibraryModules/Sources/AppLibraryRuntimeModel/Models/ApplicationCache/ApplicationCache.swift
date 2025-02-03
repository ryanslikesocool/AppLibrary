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

	@available(*, deprecated, message: "Use `updateStorage(with:) instead.`")
	func replaceStorage(with newApplicationModels: some Sequence<ApplicationModel>) {
		do {
			let modelContext = modelContainer.mainContext

			try modelContext.transaction {
				// NOTE: We can't use `modelContainer.deleteAllData()` or `modelContainer.erase()`
				// because the app crashes when trying to insert entities.
				// (I think it might delete the entity descriptions.)
				// So instead, we delete all models with matching types.
				try modelContext.delete(model: ApplicationModel.self)

				// Deleting `ApplicationModel` should cascade to include `ApplicationInstance`.
//				try modelContext.delete(model: ApplicationInstance.self)

				assert(
					((try? modelContext.count(of: ApplicationModel.self)) ?? 0)
						+ ((try? modelContext.count(of: ApplicationInstance.self)) ?? 0)
						== 0
				)

				for applicationModel in newApplicationModels {
					modelContext.insert(applicationModel)

					// Inserting `ApplicationModel` should cascade to include `ApplicationInstance`.
//					for instance in applicationModel.instances {
//						modelContext.insert(instance)
//					}
				}

//				Logger.module.debug("""
//				Instance Count: \(String(describing: try? modelContext.count(of: ApplicationInstance.self)))
//				""")
			}
		} catch {
			Logger.module.error("""
			Failed to replace storage:
			- Error: \(error.localizedDescription)
			""")
		}
	}

	func updateStorage(with newApplicationModels: some Sequence<ApplicationModel>) {
		do {
			let modelContext = modelContainer.mainContext

			try modelContext.transaction {
				try deleteNonexistentModels(in: modelContext)
				try updateExistingModels(in: modelContext)
				try insertNewModels(in: modelContext)
			}
		} catch {
			Logger.module.error("""
			Failed to update storage:
			- Error: \(error.localizedDescription)
			""")
		}

		func deleteNonexistentModels(in modelContext: ModelContext) throws {
//			// Swift hates me, specifically, so we can't use `#Predicate` here.
//			let predicate = #Predicate<ApplicationModel> { existingApplicationModel in
//				!newApplicationModels.contains { newApplicationModel in
//					newApplicationModel.bundleIdentifier == existingApplicationModel.bundleIdentifier
//				}
//			}
//
//			try modelContext.delete(
//				model: ApplicationModel.self,
//				where: predicate
//			)

			let deletingApplicationModels = try modelContext.models(ofType: ApplicationModel.self)
				.filter { existingApplicationModel in
					!newApplicationModels.contains { newApplicationModel in
						newApplicationModel.bundleIdentifier == existingApplicationModel.bundleIdentifier
					}
				}

			for model in deletingApplicationModels {
				// Deleting `ApplicationModel` should cascade to include `ApplicationInstance`.
				modelContext.delete(model)
			}
		}

		func updateExistingModels(in modelContext: ModelContext) throws {
			for newApplicationModel in newApplicationModels {
				let newBundleIdentifier = newApplicationModel.bundleIdentifier
				let predicate = #Predicate<ApplicationModel> { existingApplicationModel in
					existingApplicationModel.bundleIdentifier == newBundleIdentifier

					// `existingApplicationModel.bundleIdentifier == newApplicationModel.bundleIdentifier` doesn't compile.
					// Because of course it doesn't.
				}
				let fetchDescriptor = FetchDescriptor<ApplicationModel>(predicate: predicate)

				guard let existingApplicationModel = try modelContext.fetch(fetchDescriptor).first else {
					continue
				}

				existingApplicationModel.formUnion(newApplicationModel)
			}
		}

		func insertNewModels(in modelContext: ModelContext) throws {
			let existingApplicationModels = try modelContext.models(ofType: ApplicationModel.self)

			let insertingModels = newApplicationModels.filter { newApplicationModel in
				!existingApplicationModels.contains { existingApplicationModel in
					existingApplicationModel.bundleIdentifier == newApplicationModel.bundleIdentifier
				}
			}

			// Inserting `ApplicationModel` should cascade to include `ApplicationInstance`.
			modelContext.insert(contentsOf: insertingModels)
		}
	}
}
