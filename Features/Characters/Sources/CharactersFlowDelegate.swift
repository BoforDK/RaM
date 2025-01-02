//
//  CharactersFlowDelegate.swift
//  Characters
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import SwiftUI
import AppCore

public protocol CharactersFlowDelegate: AnyObject {
    func showTabBar(isVisible: Bool)
    func goToCharacterDetail(character: Person)
    func back()
}

public func createCharactersViewController(
    viewModel: CharactersViewModeling
) -> UIViewController {
    let view = CharactersView(viewModel: viewModel)
    return UIHostingController(rootView: view)
}
