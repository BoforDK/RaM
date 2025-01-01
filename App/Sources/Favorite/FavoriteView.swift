//
//  FavoriteView.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import Swinject
import Combine
import AppCore

struct FavoriteView: View {
    @ObservedObject var vm = FavoriteViewModel()
    var showTabBar: (Bool) -> Void

    var body: some View {
        CharacterListView(
            characters: vm.characters,
            favoriteIds: vm.characters.map(\.id),
            //todo
            goToCharacterDetail: { _ in },
            showTabBar: showTabBar
        )
        .navigationTitle("Favorites")
    }
}

#Preview {
    FavoriteView(showTabBar: { _ in })
}
