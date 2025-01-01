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

    public init() {
        self.charactersFlowCoordinator = CharactersFlowCoordinator()
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

        let favoriteView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: FavoriteView(
                    showTabBar: showTabBar(isVisible:)
                ).tint(.accent)
            )
        )

        tabBarVC?.viewControllers = [
            charactersFlowCoordinator.start(),
            favoriteView,
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
