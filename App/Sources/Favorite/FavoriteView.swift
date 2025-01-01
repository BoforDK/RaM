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
    var viewModel: FavoriteViewModeling

    var body: some View {
        CharacterListView(
            characters: viewModel.characters,
            favoriteIds: viewModel.characters.map(\.id),
            goToCharacterDetail: viewModel.actions.goToCharacterDetail,
            showTabBar: viewModel.actions.showTabBar
        )
        .navigationTitle("Favorites")
    }
}

#if DEBUG
#Preview {
    FavoriteView(viewModel: FavoriteViewModelMock())
}
#endif
