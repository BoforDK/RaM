//
//  RootViewModelMock.swift
//  App
//
//  Created by Alexander Grigorov on 27.11.2024.
//

class RootViewModelMock: RootViewModeling {
    var tabSelection: RootTab

    init(tabSelection: RootTab) {
        self.tabSelection = tabSelection
    }

    func selectCharactersView() {}
    func selectFavoritesView() {}
}
