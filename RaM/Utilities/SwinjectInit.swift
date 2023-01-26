//
//  SwinjectInit.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import Swinject

class SwinjectInit {
    static func initConteiner() {
        let network = NetworkAPI()
        let apiHandler = APIHandler(networkAPI: network)

        Container.shared.register(CharacterListHandler.self, name: .characterListHandler) { _ in
            return CharacterListHandler(apiHandler: apiHandler)
        }
        .inObjectScope(.container)
    }
}
