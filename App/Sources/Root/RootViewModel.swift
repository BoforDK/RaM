//
//  RootViewModel.swift
//  App
//
//  Created by Alexander Grigorov on 23.11.2024.
//

import Foundation

protocol RootViewModeling {
    var tabSelection: RootTab { set get }

    func selectCharactersView()
    func selectFavoritesView()
}

@Observable
class RootViewModel: RootViewModeling {
    var tabSelection: RootTab = .characters

    func selectCharactersView() {
        tabSelection = .characters
    }

    func selectFavoritesView() {
        tabSelection = .favorites
    }
}
