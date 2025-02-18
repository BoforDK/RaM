//
//  FavoriteFlowCoordinator.swift
//  App
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import UIKit
import SwiftUI
import AppUI
import AppCore
import Favorite
import CharacterDetail

public protocol FavoriteFlowCoordinatorDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
}

final class FavoriteFlowCoordinator {

    var charactersVC: UINavigationController?
    weak var flowDelegate: FavoriteFlowCoordinatorDelegate?

    public func start() -> UINavigationController {

        let charactersVC = UINavigationController(
            rootViewController: createFavoriteViewController(
                viewModel: createFavoriteViewModel(
                    flowDelegate: self,
                    homeDependencies: .init(
                        favoriteHandler: appDependencies.favoriteHandler
                    )
                )
            )
        )
        self.charactersVC = charactersVC

        return charactersVC
    }
}

extension FavoriteFlowCoordinator: FavoriteFlowDelegate {
    func showTabBar(isVisible: Bool) {
        flowDelegate?.showTabBar(isVisible: isVisible)
    }

    func goToCharacterDetail(character: Person) {
        let characterVC = createCharacterDetailViewController(
            viewModel: createCharacterDetailViewModel(
                flowDelegate: self,
                dependencies: .init(
                    favoriteHandler: appDependencies.favoriteHandler
                ),
                character: character
            )
        )

        charactersVC?.pushViewController(characterVC, animated: true)
        DispatchQueue.main.async {
            self.showTabBar(isVisible: true)
        }
    }

    @objc func back() {
        charactersVC?.popViewController(animated: true)
    }
}

extension FavoriteFlowCoordinator: CharacterDetailFlowDelegate {}
