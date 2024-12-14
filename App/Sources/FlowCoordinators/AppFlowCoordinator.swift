//
//  AppFlowCoordinator.swift
//  App
//
//  Created by Alexander Grigorov on 10.12.2024.
//

import UIKit
import SwiftUI
import AppUI

final class AppFlowCoordinator {

    var window: UIWindow?
    var tabBarVC: CustomTabBarController?

    public init(window: UIWindow? = nil) {
        self.window = window
    }

    public func start(window: UIWindow?) {
        self.window = window

        tabBarVC = CustomTabBarController(
            barIcons: [
                .rick,
                .favorite
            ]
        )

        let charactersView = UINavigationController(
            rootViewController: createCharactersViewController(
                viewModel: createCharactersViewModel(
                    flowDelegate: self,
                    homeDependencies: .init()
                )
            )
        )
        let favoriteView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: FavoriteView(
                    showTabBar: { _ in
//                        tabBarVC.setTabBarHidden(!$0, animated: true)
                    }
                ).tint(.accent)
            )
        )

        tabBarVC?.viewControllers = [
            charactersView,
            favoriteView,
        ]

        tabBarVC?.hidesBottomBarWhenPushed = true
        tabBarVC?.selectedIndex = 0

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}

extension AppFlowCoordinator: CharactersFlowDelegate {
    func showTabBar(isVisible: Bool) {
        tabBarVC?.setTabBarHidden(!isVisible, animated: true)
    }
}
