//
//  CharactersViewModeling.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import Foundation
import Combine
import AppCore

public protocol CharactersViewModeling {
    var actions: CharactersViewModelingActions { get }

    var searchText: String { get set }
    var characters: [Person] { get }
    var foundCharacters: [Person] { get }
    var favoriteIds: [Int] { get }
    var lastElementAction: (() -> Void)? { get }
    var lastElementSearchAction: (() -> Void)? { get }
}

public protocol CharactersViewModelingActions {
    func showTabBar(isVisible: Bool)
    func goToCharacterDetail(character: Person)
}

public func createCharactersViewModel(
    flowDelegate: CharactersFlowDelegate,
    homeDependencies: CharactersDependencies
) -> CharactersViewModeling {
    let vm = CharactersViewModel(
        dependencies: homeDependencies,
        flowDelegate: flowDelegate
    )

    return vm
}

public extension CharactersViewModeling where Self: CharactersViewModelingActions {
    var actions: CharactersViewModelingActions { self }
}

@Observable
final class CharactersViewModel: CharactersViewModeling, CharactersViewModelingActions {
    private var characterListHandler: CharacterListHandlerProtocol
    private var favoriteHandler: FavoriteHandlerProtocol
    private var searchHandler: SearchHandlerProtocol

    private weak var flowDelegate: CharactersFlowDelegate?

    private var lastPageWasLoaded: Bool = false
    private var lastSearchPageWasLoaded: Bool = false

    var searchText: String = "" {
        didSet {
            Task {
                try! await searchHandler.setSearchText(searchText: searchText)
                await setFoundCharacters(characters: searchHandler.characters)
                print(searchHandler.characters)
            }
        }
    }
    var characters: [Person] = []
    var foundCharacters: [Person] = []
    var favoriteIds: [Int] = []

    private var cancellable: AnyCancellable!

    public init(
        dependencies: CharactersDependencies,
        flowDelegate: CharactersFlowDelegate?
    ) {
        self.characterListHandler = dependencies.characterListHandler
        self.favoriteHandler = dependencies.favoriteHandler
        self.searchHandler = dependencies.searchHandler
        self.flowDelegate = flowDelegate

        self.characters = characterListHandler.characters
        cancellable = favoriteHandler.favorites.sink { [weak self] favorites in
            guard let self else { return }

            self.favoriteIds = favorites.map { $0.id }
        }
    }

    public var lastElementAction: (() -> Void)? {
        lastPageWasLoaded ? nil : loadNext
    }

    public var lastElementSearchAction: (() -> Void)? {
        lastSearchPageWasLoaded ? nil : loadSearchNext
    }

    public func showTabBar(isVisible: Bool) {
        flowDelegate?.showTabBar(isVisible: isVisible)
    }

    public func goToCharacterDetail(character: Person) {
        flowDelegate?.goToCharacterDetail(character: character)
    }

    private func loadNext() {
        Task {
            do {
                try await characterListHandler.loadNextPage()

                await setCharacters(characters: characters)
                await setLastPageWasLoaded(characterListHandler.lastPageWasLoaded)
            } catch {}
        }
    }

    private func loadSearchNext() {
        Task {
            do {
                try await searchHandler.loadNextPage()

                await setFoundCharacters(characters: searchHandler.characters)
                await setSearchLastPageWasLoaded(searchHandler.lastPageWasLoaded)
            } catch {}
        }
    }

    @MainActor
    private func setCharacters(characters: [Person]) {
        self.characters.removeAll()
        self.characters = characterListHandler.characters
    }

    @MainActor
    private func setLastPageWasLoaded(_ bool: Bool) {
        lastPageWasLoaded = bool
    }

    @MainActor
    private func setFoundCharacters(characters: [Person]) {
        self.foundCharacters.removeAll()
        self.foundCharacters = characters
    }

    @MainActor
    private func setSearchLastPageWasLoaded(_ bool: Bool) {
        lastSearchPageWasLoaded = bool
    }
}
