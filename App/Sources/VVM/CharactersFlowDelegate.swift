//
//  CharactersFlowDelegate.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import SwiftUI

public protocol CharactersFlowDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
}

public func createCharactersViewController(
    viewModel: CharactersViewModeling
) -> UIViewController {
    let view = CharactersView(viewModel: viewModel)
    return UIHostingController(rootView: view)
}
