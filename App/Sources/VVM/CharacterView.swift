//
//  CharacterView.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import Swinject
import AppCore

struct CharacterView: View {
    var character: Person
    @Environment(\.dismiss) private var dismiss
    @Environment(\.showTabBar) private var showTabBar
    @State var isFavorite: Bool = false
    let favoriteHandler = Container.shared.resolve(FavoriteHandlerProtocol.self,
                                                   name: .favoriteHandler)
    let navigationImageSize: CGFloat = 60
    let navigationImageName = "chevron.left"
    let gridSpacing: CGFloat = 10
    let imageSize: CGFloat = 150

    init(character: Person) {
        self.character = character
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                characterHeader()
                    .padding()

                Divider()

                characterInformation()
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background {
                Rectangle()
                    .fill(Color.listItem)
            }
            .cornerRadius(DefaultVariables.cornerRadius)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .background(Color.background)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                toolBarButton()
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear(perform: onAppear)
    }

    func toolBarButton() -> some View {
        Button(action: {
            showTabBar(true)
            dismiss()
        }, label: {
            HStack {
                Image(systemName: navigationImageName)
                    .frame(height: navigationImageSize)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)
                
                Text(character.name)
                    .foregroundColor(.gray)
                    .padding(5)
            }
            .background {
                Capsule()
                    .fill(Color.background)
                    .opacity(0.7)
            }
        })
        .buttonStyle(.plain)
    }

    func characterInformation() -> some View {
        Grid(alignment: .leading, horizontalSpacing: gridSpacing, verticalSpacing: gridSpacing) {
            textItem(name: "Status", text: character.status.rawValue)
            textItem(name: "Species", text: character.species)
            textItem(name: "Type", text: character.type)
            textItem(name: "Gender", text: character.gender)
            textItem(name: "Origin", text: character.origin.name)
            textItem(name: "Location", text: character.location.name)
        }
    }

    func characterImage() -> some View {
        AsyncImage(url: URL(string: character.image), content: { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .cornerRadius(DefaultVariables.cornerRadius)
        }, placeholder: {
            Image.placeholder
                .resizable()
                .renderingMode(.template)
                .foregroundColor(Color.background)
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
        })
    }

    func characterHeader() -> some View {
        return HStack {
            characterImage()

            VStack(alignment: .leading, spacing: 15) {
                Text("Name")
                    .foregroundColor(Color.accent)
                Text(character.name)
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            Button(action: toggleFavoriteState, label: {
                Image.favorite
                    .foregroundColor(isFavorite ? Color.foreground : Color.accent)
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
            })
        }
    }

    func textItem(name: String, text: String) -> GridRow<some View> {
        GridRow {
            Text(name)
                .foregroundColor(Color.accent)
            Text(text.isEmpty ? "–" : text)
                .bold()
        }
    }

    func toggleFavoriteState() {
        guard let strongFavoriteHandler = favoriteHandler else {
            return
        }
        if strongFavoriteHandler.contains(id: character.id) {
            strongFavoriteHandler.delete(id: character.id)
            isFavorite = false
        } else {
            strongFavoriteHandler.add(id: character.id)
            isFavorite = true
        }
    }

    func onAppear() {
        showTabBar(false)
        isFavorite = favoriteHandler?.contains(id: character.id) ?? false
    }
}
