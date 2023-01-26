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
        NavigationView {
            CharacterListView(characters: vm.characters)
            .navigationTitle("Favorites")
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
