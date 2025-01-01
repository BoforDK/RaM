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
    var tabBarVC: CustomTabBarController?

    let charactersFlowCoordinator: CharactersFlowCoordinator
    let favoriteFlowCoordinator: FavoriteFlowCoordinator

    public init() {
        self.charactersFlowCoordinator = CharactersFlowCoordinator()
        self.favoriteFlowCoordinator = FavoriteFlowCoordinator()
    }

    public func start(window: UIWindow?) {
        self.window = window
        self.charactersFlowCoordinator.flowDelegate = self

        tabBarVC = CustomTabBarController(
            barIcons: [
                .rick,
                .favorite
            ]
        )

        tabBarVC?.viewControllers = [
            charactersFlowCoordinator.start(),
            favoriteFlowCoordinator.start(),
        ]

        tabBarVC?.hidesBottomBarWhenPushed = true
        tabBarVC?.selectedIndex = 0

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

extension AppFlowCoordinator: CharactersFlowCoordinatorDelegate {
    func showTabBar(isVisible: Bool) {
        tabBarVC?.setTabBarHidden(!isVisible, animated: true)
    }
}
