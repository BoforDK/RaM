//
//  CharactersViewModeling.swift
//  App
//
//  Created by Alexander Grigorov on 14.12.2024.
//

import Foundation

public protocol CharactersViewModeling {
    func showTabBar(isVisible: Bool)
}

public func createCharactersViewModel(
    flowDelegate: CharactersFlowDelegate,
    homeDependencies: CharacterDependencies
) -> CharactersViewModeling {
    let vm = CharactersViewModel(
        dependencies: homeDependencies
    )
    vm.flowDelegate = flowDelegate

    return vm
}

public final class CharactersViewModel: CharactersViewModeling {
    let dependencies: CharacterDependencies
    weak var flowDelegate: CharactersFlowDelegate?

    public init(
        dependencies: CharacterDependencies
    ) {
        self.dependencies = dependencies
    }

    public func showTabBar(isVisible: Bool) {
        flowDelegate?.showTabBar(isVisible: isVisible)
    }
}
