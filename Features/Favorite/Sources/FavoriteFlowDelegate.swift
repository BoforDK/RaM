//
//  FavoriteFlowDelegate.swift
//  Favorite
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import SwiftUI
import AppCore

public protocol FavoriteFlowDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
    func goToCharacterDetail(character: Person)
}

public func createFavoriteViewController(
    viewModel: FavoriteViewModeling
) -> UIViewController {
    let view = FavoriteView(viewModel: viewModel)
    return UIHostingController(rootView: view)
}
