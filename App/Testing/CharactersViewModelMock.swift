//
//  CharactersViewModelMock.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import AppCore

final class CharactersViewModelMock: CharactersViewModeling, CharactersViewModelingActions {
    var searchText: String
    var characters: [Person]
    var foundCharacters: [Person]
    var favoriteIds: [Int]
    var lastElementAction: (() -> Void)?
    var lastElementSearchAction: (() -> Void)?

    public init(
        searchText: String = "",
        characters: [Person] = .mock,
        foundCharacters: [Person] = [],
        favoriteIds: [Int] = [1, 3, 5, 7],
        lastElementAction: (() -> Void)? = nil,
        lastElementSearchAction: (() -> Void)? = nil
    ) {
        self.searchText = searchText
        self.characters = characters
        self.foundCharacters = foundCharacters
        self.favoriteIds = favoriteIds
        self.lastElementAction = lastElementAction
        self.lastElementSearchAction = lastElementSearchAction
    }

    func showTabBar(isVisible: Bool) {}
}
