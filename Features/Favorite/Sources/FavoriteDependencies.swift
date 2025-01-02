//
//  FavoriteDependencies.swift
//  Favorite
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import AppCore

public struct FavoriteDependencies {
    let favoriteHandler: FavoriteHandlerProtocol
    
    
    public init(
        favoriteHandler: FavoriteHandlerProtocol
    ) {
        self.favoriteHandler = favoriteHandler
    }
}
