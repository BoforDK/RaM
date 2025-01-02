//
//  CharacterDetailView.swift
//  CharacterDetail
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import SwiftUI
import AppCore
import AppUI

struct CharacterDetailView: View {
    @State var viewModel: CharacterDetailViewModeling
    let navigationImageSize: CGFloat = 60
    let navigationImageName = "chevron.left"
    let gridSpacing: CGFloat = 10
    let imageSize: CGFloat = 150

    public init(viewModel: CharacterDetailViewModeling) {
        self.viewModel = viewModel
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
        .background(Color.background)
        .task {
            viewModel.actions.onAppear()
        }
    }

    func characterInformation() -> some View {
        Grid(alignment: .leading, horizontalSpacing: gridSpacing, verticalSpacing: gridSpacing) {
            textItem(name: "Status", text: viewModel.status)
            textItem(name: "Species", text: viewModel.species)
            textItem(name: "Type", text: viewModel.type)
            textItem(name: "Gender", text: viewModel.gender)
            textItem(name: "Origin", text: viewModel.origin)
            textItem(name: "Location", text: viewModel.location)
        }
    }

    func characterImage() -> some View {
        AsyncImage(url: URL(string: viewModel.image), content: { image in
            image
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
                .cornerRadius(DefaultVariables.cornerRadius)
        }, placeholder: {
            Image.rick
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
                Text(viewModel.name)
                    .font(.title)
                    .bold()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            Button(action: viewModel.actions.toggleFavoriteState, label: {
                Image.favorite
                    .foregroundColor(viewModel.isFavorite ? Color.foreground : Color.accent)
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
}

#if DEBUG
#Preview {
    CharacterDetailView(
        viewModel: CharacterDetailViewModelMock()
    )
}
#endif
