//
//  SwinjectInit.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import Swinject
import AppUI
import AppCore

final class SwinjectInit {
    static func initConteiner() {
        let network = NetworkAPI()
        let apiHandler = APIHandler(networkAPI: network)

        Container.shared.register(CharacterListHandler.self, name: .characterListHandler) { _ in
            return CharacterListHandler(apiHandler: apiHandler)
        }
        .inObjectScope(.container)

        Container.shared.register(SearchHandlerProtocol.self, name: .searchHandler) { _ in
            return SearchHandler(apiHandler: apiHandler)
        }
        .inObjectScope(.container)

        Container.shared.register(FavoriteHandlerProtocol.self, name: .favoriteHandler) { _ in
            return FavoriteHandler(favoriteRepository: FavoriteRepository(), apiHandler: apiHandler)
        }
        .inObjectScope(.container)
    }
}
