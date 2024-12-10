//
//  SearchViewModel.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Swinject
import AppCore

final class CharacterSearchViewModel: ObservableObject {
    @Published var characters = [Person]()
    @Published var lastPageWasLoaded: Bool = true
    var showTabBar: (Bool) -> Void
    private let searchListHandler: SearchHandlerProtocol

    convenience init(
        searchText: String,
        showTabBar: @escaping (Bool) -> Void
    ) {
        guard let searchListHandler = Container.shared.resolve(SearchHandlerProtocol.self, name: .searchHandler) else {
            fatalError("SearchHandlerProtocol has to be init in SwinjectInit")
        }
        self.init(
            searchListHandler: searchListHandler,
            searchText: searchText,
            showTabBar: showTabBar
        )
    }

    init(
        searchListHandler: SearchHandlerProtocol,
        searchText: String,
        showTabBar: @escaping (Bool) -> Void
    ) {
        self.searchListHandler = searchListHandler
        self.lastPageWasLoaded = searchListHandler.lastPageWasLoaded
        self.showTabBar = showTabBar
        Task { [searchListHandler] in
            try await searchListHandler.setSearchText(searchText: searchText)
            await setCharacters(characters: searchListHandler.characters)
        }
    }

    func loadNext() {
        Task {
            do {
                try await searchListHandler.loadNextPage()
                await setCharacters(characters: searchListHandler.characters)
                await setLastPageWasLoaded(searchListHandler.lastPageWasLoaded)
            } catch {
                fatalError()
            }
        }
    }

    @MainActor
    private func setCharacters(characters: [Person]) {
        self.characters = characters
    }

    @MainActor
    private func setLastPageWasLoaded(_ bool: Bool) {
        lastPageWasLoaded = bool
    }
}
