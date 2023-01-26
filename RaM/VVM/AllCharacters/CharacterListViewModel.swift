//
//  AllCharactersViewModel.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import Foundation
import Swinject

final class AllCharactersViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var lastPageWasLoaded: Bool = false
    @Published var favoriteIds = [Int]()
    private var characterListHandler: CharacterListHandlerProtocol

    convenience init() {
        guard let characterListHandler = Container.shared.resolve(CharacterListHandler.self,
                                                                  name: .characterListHandler) else {
            fatalError("CharacterListHandler has to be init in SwinjectInit")
        }
        self.init(characterListHandler: characterListHandler)
    }

    init(characterListHandler: CharacterListHandlerProtocol) {
        self.characterListHandler = characterListHandler
        self.characters = characterListHandler.characters
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
