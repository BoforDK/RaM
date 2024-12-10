//
//  SearchView.swift
//  App
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

    init(
        searchText: String,
        showTabBar: @escaping (Bool) -> Void
    ) {
        self.searchText = searchText
        vm = .init(
            searchText: searchText,
            showTabBar: showTabBar
        )
    }

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: stackSpacing) {
                ForEach(vm.characters, id: \.id) { character in
                    NavigationLink(destination: {
                        CharacterView(character: character, showTabBar: vm.showTabBar)
                    }, label: {
                        CharacterItemView(character: character, isFavorite: false)
                            .padding()
                            .padding([.horizontal], itemHorizontalPadding)
                    })
                    .buttonStyle(.plain)
                }
                .onAppear {
                    vm.showTabBar(false)
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
        SearchView(searchText: "Rick", showTabBar: { _ in })
    }
}

