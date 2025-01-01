//
//  CharacterDetailFlowDelegate.swift
//  App
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import SwiftUI
import AppCore

public protocol CharacterDetailFlowDelegate: AnyObject { }

public func createCharacterDetailViewController(
    viewModel: CharacterDetailViewModeling
) -> UIViewController {
    let view = CharacterDetailView(viewModel: viewModel)
    return UIHostingController(rootView: view)
}
