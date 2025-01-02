//
//  FavoriteViewModel.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Combine
import AppCore
import AppUI

public protocol FavoriteViewModeling {
    var actions: FavoriteViewModelingActions { get }

    var characters: [Person] { get }
}

public protocol FavoriteViewModelingActions {
    func showTabBar(isVisible: Bool)
    func goToCharacterDetail(character: Person)
}

public func createFavoriteViewModel(
    flowDelegate: FavoriteFlowDelegate,
    homeDependencies: FavoriteDependencies
) -> FavoriteViewModeling {
    let vm = FavoriteViewModel(
        dependencies: homeDependencies,
        flowDelegate: flowDelegate
    )

    return vm
}

public extension FavoriteViewModeling where Self: FavoriteViewModelingActions {
    var actions: FavoriteViewModelingActions { self }
}

@Observable
final class FavoriteViewModel: FavoriteViewModeling, FavoriteViewModelingActions {
    private let favoriteHandler: FavoriteHandlerProtocol

    private weak var flowDelegate: FavoriteFlowDelegate?

    var characters = [Person]()
    private var cancellable: AnyCancellable!

    init(
        dependencies: FavoriteDependencies,
        flowDelegate: FavoriteFlowDelegate
    ) {
        self.favoriteHandler = dependencies.favoriteHandler
        self.flowDelegate = flowDelegate
        cancellable = favoriteHandler.favorites.sink { [weak self] ids in
            guard let strongSelf = self else {
                return
            }
            strongSelf.setCharacters(characters: ids)
        }
    }

    func showTabBar(isVisible: Bool) {
        flowDelegate?.showTabBar(isVisible: isVisible)
    }

    func goToCharacterDetail(character: Person) {
        flowDelegate?.goToCharacterDetail(character: character)
    }

    private func setCharacters(characters: [Person]) {
        self.characters = characters
    }
}
