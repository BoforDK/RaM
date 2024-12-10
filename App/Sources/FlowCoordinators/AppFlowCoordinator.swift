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

        let tabBarVC = CustomTabBarController()

        let charactersView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: CharactersView()
                    .tint(.accent)
            )
        )
        let favoriteView = UINavigationController(
            rootViewController: UIHostingController(
                rootView: FavoriteView().tint(.accent)
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
