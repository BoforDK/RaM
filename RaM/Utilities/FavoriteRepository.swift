//
//  FavoriteRepository.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import CoreData
import Combine

class FavoriteRepository: NSObject, NSFetchedResultsControllerDelegate {
    private(set) var favorites = CurrentValueSubject<[CDFavorite], Never>([])
    private let fetchController: NSFetchedResultsController<CDFavorite>
    private let context: NSManagedObjectContext

    override init() {
        context = PersistenceController.shared.container.viewContext
        let relationshipFetchReques: NSFetchRequest<CDFavorite> = CDFavorite.fetchRequest()
        let sortByTitle = NSSortDescriptor(key: "id", ascending: true)
        relationshipFetchReques.sortDescriptors = [sortByTitle]
        fetchController = NSFetchedResultsController(fetchRequest: relationshipFetchReques,
                                                     managedObjectContext: context,
                                                     sectionNameKeyPath: nil,
                                                     cacheName: nil)
        super.init()

        fetchController.delegate = self

        do {
            try fetchController.performFetch()
            favorites.value = fetchController.fetchedObjects ?? []
        } catch {
            NSLog("Error: could not fetch objects")
        }
    }

    func delete(id: Int64) throws {
        let foundFavorite = favorites.value.first { $0.id == id }
        if let strongFoundFavorite = foundFavorite {
            context.delete(strongFoundFavorite)
            try context.save()
        }
    }

    func create(id: Int64) throws {
        guard findById(id) == nil else {
            return
        }
        let Favorite = CDFavorite(context: context)
        Favorite.id = id
        try context.save()
    }

    func findById(_ id: Int64) -> CDFavorite? {
        return favorites.value.first{ $0.id == id }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let favorites =  controller.fetchedObjects as? [CDFavorite] else {
            return
        }
        NSLog("Content has changed, reloading medias")
        self.favorites.value = favorites
    }
}
