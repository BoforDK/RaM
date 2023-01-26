//
//  ContentView.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        AllCharactersView(vm: .init(characterListHandler: CharacterListHandler(apiHandler: APIHandler(networkAPI: NetworkAPI()))))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
