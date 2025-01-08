//
//  CharacterDetailViewModeling.swift
//  CharacterDetail
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import Foundation
import AppCore

public protocol CharacterDetailViewModeling {
    var actions: CharacterDetailViewModelingActions { get }

    var isError: Bool { get }
    var isFavorite: Bool { get }
    var name: String { get }
    var status: String { get }
    var species: String { get }
    var type: String { get }
    var gender: String { get }
    var origin: String { get }
    var location: String { get }
    var image: String { get }
}

public protocol CharacterDetailViewModelingActions {
    func onAppear()
    func toggleFavoriteState()
    func retry()
}

public func createCharacterDetailViewModel(
    flowDelegate: CharacterDetailFlowDelegate,
    dependencies: CharacterDetailDependencies,
    character: Person
) -> CharacterDetailViewModeling {
    let vm = CharacterDetailViewModel(
        dependencies: dependencies,
        flowDelegate: flowDelegate,
        character: character
    )

    return vm
}

public extension CharacterDetailViewModeling where Self: CharacterDetailViewModelingActions {
    var actions: CharacterDetailViewModelingActions { self }
}

@Observable
final class CharacterDetailViewModel: CharacterDetailViewModeling, CharacterDetailViewModelingActions {
    private var favoriteHandler: FavoriteHandlerProtocol

    private weak var flowDelegate: CharacterDetailFlowDelegate?

    public var isFavorite: Bool = false
    var character: Person

    public init(
        dependencies: CharacterDetailDependencies,
        flowDelegate: CharacterDetailFlowDelegate,
        character: Person
    ) {
        self.favoriteHandler = dependencies.favoriteHandler
        self.flowDelegate = flowDelegate
        self.character = character
    }
    
    public var isError: Bool {
        favoriteHandler.isError
    }

    public var name: String {
        character.name
    }

    public var status: String {
        character.status.rawValue
    }

    public var species: String {
        character.species
    }

    public var type: String {
        character.type
    }

    public var gender: String {
        character.gender
    }

    public var origin: String {
        character.origin.name
    }

    public var location: String {
        character.location.name
    }

    public var image: String {
        character.image
    }

    func onAppear() {
        isFavorite = favoriteHandler.contains(id: character.id)
    }

    func toggleFavoriteState() {
        if favoriteHandler.contains(id: character.id) {
            favoriteHandler.delete(id: character.id)
            isFavorite = false
        } else {
            favoriteHandler.add(id: character.id)
            isFavorite = true
        }
    }
    
    func retry() {
        favoriteHandler.retry()
    }
}
