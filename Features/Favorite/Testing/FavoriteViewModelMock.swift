//
//  FavoriteViewModelMock.swift
//  Favorite
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import AppCore

final class FavoriteViewModelMock: FavoriteViewModeling, FavoriteViewModelingActions {
    var characters: [Person]

    public init(
        characters: [Person] = .mock
    ) {
        self.characters = characters
    }

    func showTabBar(isVisible: Bool) {}

    func goToCharacterDetail(character: AppCore.Person) {}
}
