//
//  AppFlowCoordinator.swift
//  App
//
//  Created by Alexander Grigorov on 10.12.2024.
//

import UIKit
import SwiftUI
import AppUI
import AppCore

final class AppFlowCoordinator {

    var window: UIWindow?
    var tabBarVC: UITabBarController?

    let charactersFlowCoordinator: CharactersFlowCoordinator
    let favoriteFlowCoordinator: FavoriteFlowCoordinator

    public init() {
        self.charactersFlowCoordinator = CharactersFlowCoordinator()
        self.favoriteFlowCoordinator = FavoriteFlowCoordinator()
    }

    public func start(window: UIWindow?) {
        self.window = window
        self.charactersFlowCoordinator.flowDelegate = self

        let firstVC = charactersFlowCoordinator.start()
        firstVC.tabBarItem = UITabBarItem(title: "", image: .persons, tag: 0)

        let secondVC = favoriteFlowCoordinator.start()
        secondVC.tabBarItem = UITabBarItem(title: "", image: .favorite, tag: 1)

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [firstVC, secondVC]

        tabBarVC = tabBarController

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

extension AppFlowCoordinator: CharactersFlowCoordinatorDelegate {
    func showTabBar(isVisible: Bool) {
        tabBarVC?.setTabBarHidden(!isVisible, animated: true)
    }
}
