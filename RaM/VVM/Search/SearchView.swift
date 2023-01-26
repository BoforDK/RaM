//
//  SearchView.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var vm: CharacterSearchViewModel
    @State var characters = [Character]()
    var searchText: String

    private var stackSpacing: CGFloat = 15
    private var itemHorizontalPadding: CGFloat = 15

    init(searchText: String) {
        self.searchText = searchText
        vm = .init(searchText: searchText)
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: stackSpacing) {
                ForEach(vm.characters, id: \.id) { character in
                    NavigationLink(destination: {
                        CharacterView(character: character)
                    }, label: {
                        CharacterItemView(character: character, isFavorite: false)
                            .padding()
                            .padding([.horizontal], itemHorizontalPadding)
                    })
                    .buttonStyle(.plain)
                }
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .opacity(!searchText.isEmpty && !vm.lastPageWasLoaded ? 1 : 0)
                    .onAppear {
                        vm.loadNext()
                    }
            }
            .frame(maxWidth: .infinity)
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(searchText: "Rick")
    }
}

