//
//  AllCharactersView.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct AllCharactersView: View {
    @StateObject var vm: AllCharactersViewModel

    var body: some View {
        CharacterListView(characters: vm.characters,
                          lastElementAction: vm.lastPageWasLoaded ? nil : vm.loadNext)
    }
}

//struct AllCharactersView_Previews: PreviewProvider {
//    static var previews: some View {
//        AllCharactersView()
//    }
//}
