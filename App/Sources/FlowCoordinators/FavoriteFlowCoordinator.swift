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

public protocol FavoriteFlowCoordinatorDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
}

final class FavoriteFlowCoordinator: UIViewController {

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

        let customBackButton = UIBarButtonItem(
            title: character.name,
            style: .plain,
            target: self,
            action: #selector(back)
        )
        customBackButton.tintColor = .gray

        characterVC.navigationItem.leftBarButtonItem = customBackButton
        characterVC.navigationItem.hidesBackButton = true

        charactersVC?.pushViewController(characterVC, animated: true)
        charactersVC?.interactivePopGestureRecognizer?.delegate = self
        charactersVC?.interactivePopGestureRecognizer?.isEnabled = true
        DispatchQueue.main.async {
            characterVC.navigationItem.hidesBackButton = true
            self.showTabBar(isVisible: true)
        }
    }

    @objc func back() {
        charactersVC?.popViewController(animated: true)
    }
}

extension FavoriteFlowCoordinator: CharacterDetailFlowDelegate {}

extension FavoriteFlowCoordinator: UIGestureRecognizerDelegate {}
