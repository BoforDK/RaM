//
//  RootViewModelMock.swift
//  App
//
//  Created by Alexander Grigorov on 27.11.2024.
//

//todo: delete?
class RootViewModelMock: RootViewModeling {
    var tabSelection: RootTab

    init(tabSelection: RootTab) {
        self.tabSelection = tabSelection
    }

    func selectCharactersView() {}
    func selectFavoritesView() {}
}
