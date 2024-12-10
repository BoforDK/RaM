//
//  AllCharactersView.swift
//  App
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct AllCharactersView: View {
    @StateObject var vm = AllCharactersViewModel()
    //todo
    var showTabBar: (Bool) -> Void

    var body: some View {
        CharacterListView(
            characters: vm.characters,
            favoriteIds: vm.favoriteIds,
            lastElementAction: vm.lastPageWasLoaded ? nil : vm.loadNext,
            showTabBar: showTabBar
        )
    }
}

//TODO: uncomment
//struct AllCharactersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCharactersView()
//    }
//}
