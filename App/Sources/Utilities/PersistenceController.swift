//
//  PersistenceController.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import CoreData

class PersistenceController {
    static var shared: PersistenceController = PersistenceController()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "RaM")
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

    func saveContext() {
      let context = container.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }
}
