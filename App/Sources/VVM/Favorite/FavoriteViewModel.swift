//
//  FavoriteViewModel.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Swinject
import Combine
import AppCore
import AppUI

final class FavoriteViewModel: ObservableObject {
    @Published var characters = [Person]()
    private var cancellable: AnyCancellable!
    private let favoriteRepository: FavoriteHandlerProtocol

    convenience init() {
        guard let favoriteRepository = Container.shared.resolve(FavoriteHandlerProtocol.self,
                                                                name: .favoriteHandler) else {
            fatalError("CharacterListHandler has to be init in SwinjectInit")
        }
        self.init(favoriteRepository: favoriteRepository)
    }

    init(favoriteRepository: FavoriteHandlerProtocol) {
        self.favoriteRepository = favoriteRepository
        cancellable = favoriteRepository.favorites.sink { [weak self] ids in
            guard let strongSelf = self else {
                return
            }
            strongSelf.setCharacters(characters: ids)
        }
    }

    private func setCharacters(characters: [Person]) {
        self.characters = characters
    }
}
