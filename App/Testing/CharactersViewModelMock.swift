//
//  CharactersViewModelMock.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import AppCore

//todo: mocks
final class CharactersViewModelMock: CharactersViewModeling, CharactersViewModelingActions {
    var searchText: String = ""
    var characters: [Person] = []
    var foundCharacters: [Person] = []
    var favoriteIds: [Int] = []
    var lastElementAction: (() -> Void)?
    var lastElementSearchAction: (() -> Void)?

    public init() {}

    func showTabBar(isVisible: Bool) {}
}
