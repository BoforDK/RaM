//
//  AllCharactersViewModel.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import Foundation
import Swinject
import Combine
import AppCore

final class AllCharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var lastPageWasLoaded: Bool = false
    @Published var favoriteIds = [Int]()
    private var characterListHandler: CharacterListHandlerProtocol
    private var favoriteHandler: FavoriteHandlerProtocol?
    private var cancellable: AnyCancellable!

    convenience init() {
        guard let characterListHandler = Container.shared.resolve(CharacterListHandler.self,
                                                                  name: .characterListHandler) else {
            fatalError("CharacterListHandler has to be init in SwinjectInit")
        }
        guard let favoriteHandler = Container.shared.resolve(FavoriteHandlerProtocol.self,
                                                              name: .favoriteHandler) else {
            fatalError("favoritesHandler has to be init in SwinjectInit")
        }
        self.init(characterListHandler: characterListHandler, favoriteHandler: favoriteHandler)
    }

    init(characterListHandler: CharacterListHandlerProtocol, favoriteHandler: FavoriteHandlerProtocol) {
        self.characterListHandler = characterListHandler
        self.characters = characterListHandler.characters
        cancellable = favoriteHandler.favorites.sink { [weak self] favorites in
            guard let strongSelf = self else {
                return
            }
            strongSelf.favoriteIds = favorites.map { $0.id }
        }
    }

    func loadNext() {
        Task {
            do {
                try await characterListHandler.loadNextPage()
                await setCharacters(characters: characters)
                await setLastPageWasLoaded(characterListHandler.lastPageWasLoaded)
            } catch {}
        }
    }

    @MainActor
    private func setCharacters(characters: [Character]) {
        self.characters.removeAll()
        self.characters = characterListHandler.characters
    }

    @MainActor
    private func setLastPageWasLoaded(_ bool: Bool) {
        lastPageWasLoaded = bool
    }
}
