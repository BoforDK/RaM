//
//  CharactersDependencies.swift
//  Characters
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import AppCore

public struct CharactersDependencies {
    let characterListHandler: CharacterListHandlerProtocol
    let favoriteHandler: FavoriteHandlerProtocol
    let searchHandler: SearchHandlerProtocol
    
    public init(
        characterListHandler: CharacterListHandlerProtocol,
        favoriteHandler: FavoriteHandlerProtocol,
        searchHandler: SearchHandlerProtocol
    ) {
        self.characterListHandler = characterListHandler
        self.favoriteHandler = favoriteHandler
        self.searchHandler = searchHandler
    }
}
