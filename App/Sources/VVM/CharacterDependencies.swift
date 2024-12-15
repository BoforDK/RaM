//
//  CharacterDependencies.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import AppCore

public struct CharacterDependencies {
    let characterListHandler: CharacterListHandlerProtocol
    let favoriteHandler: FavoriteHandlerProtocol
    let searchHandler: SearchHandlerProtocol
}
