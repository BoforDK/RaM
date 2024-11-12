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
        guard
            let model = NSManagedObjectModel.mergedModel(
                from: [
                    Bundle(for: CDFavorite.self)
                ]
            )
        else {
            fatalError("Failed to locate Core Data model")
        }
        
        container = NSPersistentContainer(name: "RaM", managedObjectModel: model)
        container.persistentStoreDescriptions.forEach { storeDesc in
            storeDesc.shouldMigrateStoreAutomatically = true
            storeDesc.shouldInferMappingModelAutomatically = true
        }

        container.loadPersistentStores { description, error in
            if let error = error {
                NSLog("Core Data failed to load: \(error.localizedDescription)")
                fatalError("Core Data failed to load: \(error.localizedDescription) \(self.container.persistentStoreCoordinator.description)")
            }
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
