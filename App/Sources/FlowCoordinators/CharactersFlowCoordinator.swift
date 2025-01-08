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
import CharacterDetail

public protocol CharactersFlowCoordinatorDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
}

final class CharactersFlowCoordinator {

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

        charactersVC?.pushViewController(characterVC, animated: true)
        DispatchQueue.main.async {
            self.showTabBar(isVisible: true)
        }
    }

    @objc func back() {
        charactersVC?.popViewController(animated: true)
    }
}

extension CharactersFlowCoordinator: CharacterDetailFlowDelegate {}
