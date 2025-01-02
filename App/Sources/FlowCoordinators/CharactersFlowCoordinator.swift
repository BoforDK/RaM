//
//  CharactersFlowCoordinator.swift
//  App
//
//  Created by Alexander Grigorov on 26.12.2024.
//

import UIKit
import SwiftUI
import AppUI
import AppCore
import Characters

public protocol CharactersFlowCoordinatorDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
}

final class CharactersFlowCoordinator: UIViewController {

    var charactersVC: UINavigationController?
    weak var flowDelegate: CharactersFlowCoordinatorDelegate?

    public func start() -> UINavigationController {
        let charactersVC = UINavigationController(
            rootViewController: createCharactersViewController(
                viewModel: createCharactersViewModel(
                    flowDelegate: self,
                    homeDependencies: .init(
                        characterListHandler: appDependencies.characterListHandler,
                        favoriteHandler: appDependencies.favoriteHandler,
                        searchHandler: appDependencies.searchHandler
                    )
                )
            )
        )
        self.charactersVC = charactersVC

        return charactersVC
    }
}

extension CharactersFlowCoordinator: CharactersFlowDelegate {
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

extension CharactersFlowCoordinator: CharacterDetailFlowDelegate {}

extension CharactersFlowCoordinator: UIGestureRecognizerDelegate {}
