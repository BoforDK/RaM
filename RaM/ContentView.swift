//
//  ContentView.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            AllCharactersView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
