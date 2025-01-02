//
//  CharacterDetailDependencies.swift
//  CharacterDetail
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import AppCore

public struct CharacterDetailDependencies {
    var favoriteHandler: FavoriteHandlerProtocol
    
    public init(
        favoriteHandler: FavoriteHandlerProtocol
    ) {
        self.favoriteHandler = favoriteHandler
    }
}
