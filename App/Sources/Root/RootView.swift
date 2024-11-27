//
//  RootView.swift
//  App
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI
import AppUI

struct RootView: View {
    @ScaledMetric(relativeTo: .body) var tabBarIconSize: CGFloat = 40

    @State var viewModel: RootViewModeling

    init(viewModel: RootViewModeling = RootViewModel()) {
        self.viewModel = viewModel
    }

    var body: some View {
        TabView(selection: $viewModel.tabSelection) {
            NavigationStack {
                CharactersView()
            }
            .tag(RootTab.characters)

            NavigationStack {
                FavoriteView()
            }
            .tag(RootTab.favorites)
        }
        .toolbar(.hidden, for: .tabBar)
        .floatingBar {
            barButton(
                action: viewModel.selectCharactersView,
                image: Image.rick,
                isSelected: viewModel.tabSelection == .characters
            )

            barButton(
                action: viewModel.selectFavoritesView,
                image: Image.favorite,
                isSelected: viewModel.tabSelection == .favorites
            )
        }
    }

    private func barButton(
        action: @escaping () -> Void,
        image: Image,
        isSelected: Bool
    ) -> some View {
        Button(action: action, label: {
            image
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .foregroundColor(isSelected ? Color.blue : Color.accent)
                .frame(width: tabBarIconSize, height: tabBarIconSize)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(
            viewModel: RootViewModelMock(
                tabSelection: .characters
            )
        )
    }
}
