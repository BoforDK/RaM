//
//  ContentView.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        CustomTabView(content: {
            NavigationView {
                CharactersView()
                    .navigationTitle("Characters")
            }

            NavigationView {
                FavoriteView()
                    .navigationTitle("Favorites")
            }
        }, tabBar: {
            Image.placeholder
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
            Image.favorite
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
