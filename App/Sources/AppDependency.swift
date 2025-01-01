//
//  AppDependency.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import AppCore

final class AppDependency {
    private let favoriteRepository: FavoriteRepository
    private let network: NetworkAPI
    private let apiHandler: APIHandler

    let characterListHandler: CharacterListHandlerProtocol
    let searchHandler: SearchHandlerProtocol
    let favoriteHandler: FavoriteHandlerProtocol

    public init() {
        self.network = NetworkAPI()
        self.apiHandler = APIHandler(networkAPI: network)
        self.favoriteRepository = FavoriteRepository()
        self.characterListHandler = CharacterListHandler(
            apiHandler: apiHandler
        )
        self.searchHandler = SearchHandler(apiHandler: apiHandler)
        self.favoriteHandler = FavoriteHandler(
            favoriteRepository: favoriteRepository,
            apiHandler: apiHandler
        )
    }
}

let appDependencies = AppDependency()
