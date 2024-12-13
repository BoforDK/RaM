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

    public init(window: UIWindow? = nil) {
        self.window = window
    }

    var window: UIWindow?

    public func start(window: UIWindow?) {
        self.window = window

        let tabBarVC = CustomTabBarController(
            barIcons: [
                .rick,
                .favorite
            ]
        )

        let charactersView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: CharactersView(
                    showTabBar: {
                        tabBarVC.setTabBarHidden(!$0, animated: true)
                    }
                )
                .tint(.accent)
            )
        )
        let favoriteView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: FavoriteView(
                    showTabBar: {
                        tabBarVC.setTabBarHidden(!$0, animated: true)
                    }
                ).tint(.accent)
            )
        )

        tabBarVC.viewControllers = [
            charactersView,
            favoriteView,
        ]

        tabBarVC.hidesBottomBarWhenPushed = true
        tabBarVC.selectedIndex = 0

        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}
