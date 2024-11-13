//
//  CharacterItemView.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI
import AppCore

struct CharacterItemView: View {
    var character: Person
    var isFavorite: Bool

    var body: some View {
        HStack(alignment: .top) {
            characterImage()
                .padding(.trailing, 10)

            characterInformation()

            navigationImage()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func characterImage() -> some View {
        AsyncImage(url: URL(string: character.image),
                   content: { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
        }, placeholder: imagePlaceholder)
    }

    func imagePlaceholder() -> some View {
        Image.placeholder
            .resizable()
            .renderingMode(.template)
            .foregroundColor(Color.background)
            .scaledToFit()
            .frame(width: 60, height: 60)
            .cornerRadius(10)
    }

    func characterInformation() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text("\(character.name)")
                    .font(.title3)
                    .fontWeight(.heavy)
                Image.favorite
                    .foregroundColor(Color.foreground)
                    .opacity(isFavorite ? 1 : 0)
            }
            Text("\(character.status.rawValue)")
                .fontWeight(.semibold)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func navigationImage() -> some View {
        Image(systemName: "chevron.right")
            .frame(height: 60)
            .fontWeight(.bold)
            .foregroundColor(.gray)
    }
}

struct CharacterListItem_Previews: PreviewProvider {
    static var previews: some View {
        //swiftlint:disable rule force_unwrapping
        CharacterItemView(character: defaultCharacter.first!, isFavorite: true)
    }
}
