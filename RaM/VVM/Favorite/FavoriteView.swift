//
//  FavoriteView.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import Swinject
import Combine

struct FavoriteView: View {
    @ObservedObject var vm = FavoriteViewModel()

    var body: some View {
        CharacterListView(characters: vm.characters,
                          favoriteIds: vm.characters.map {$0.id})
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
