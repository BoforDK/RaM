//
//  CharacterDetailViewModelMock.swift
//  App
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import Foundation

public final class CharacterDetailViewModelMock: CharacterDetailViewModeling, CharacterDetailViewModelingActions {
    public var isFavorite: Bool
    public var name: String
    public var status: String
    public var species: String
    public var type: String
    public var gender: String
    public var origin: String
    public var location: String
    public var image: String

    public init(
        isFavorite: Bool = true,
        name: String = "Rick Sanchez",
        status: String = "Alive",
        species: String = "Human",
        type: String = "",
        gender: String = "Male",
        origin: String = "Earth (C-137)",
        location: String = "Citadel of Ricks",
        image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    ) {
        self.isFavorite = isFavorite
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
    }

    public func onAppear() {}
    public func toggleFavoriteState() {}
}
