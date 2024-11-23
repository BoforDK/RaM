//
//  PersistenceController.swift
//  AppCore
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import CoreData

public class PersistenceController {

    public static var shared: PersistenceController = PersistenceController()

    public let container: NSPersistentContainer

    private init() {
        // Locate the Core Data model
        guard let model = NSManagedObjectModel.mergedModel(
            from: [Bundle(for: CDFavorite.self)]
        ) else {
            fatalError("Failed to locate Core Data model")
        }

        // Initialize NSPersistentCloudKitContainer
        container = NSPersistentCloudKitContainer(name: "RaM", managedObjectModel: model)

        // Configure the persistent store descriptions
        guard let storeDescription = container.persistentStoreDescriptions.first else {
            fatalError("No persistent store description found.")
        }

        // Enable CloudKit-specific options
        storeDescription.setOption(
            true as NSNumber,
            forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey
        )
        storeDescription.setOption(
            true as NSNumber,
            forKey: NSPersistentHistoryTrackingKey
        )

        // Configure the persistent container
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        // Configure the context
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy

        // Optional: Pin to the current query generation
        do {
            try container.viewContext.setQueryGenerationFrom(.current)
        } catch {
            fatalError("Failed to pin viewContext to the current generation: \(error)")
        }
    }

    public func saveContext() {
        let context = container.viewContext

        guard context.hasChanges else {
            return
        }

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
