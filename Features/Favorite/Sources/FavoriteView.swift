//
//  FavoriteView.swift
//  Favorite
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import Combine
import AppCore
import AppUI

struct FavoriteView: View {
    @State var viewModel: FavoriteViewModeling

    var body: some View {
        CharacterListView(
            characters: viewModel.characters,
            favoriteIds: viewModel.characters.map(\.id),
            goToCharacterDetail: viewModel.actions.goToCharacterDetail,
            showTabBar: viewModel.actions.showTabBar
        )
        .navigationTitle("Favorites")
        .background(Color.background)
    }
}

#if DEBUG
#Preview {
    FavoriteView(viewModel: FavoriteViewModelMock())
}
#endif
