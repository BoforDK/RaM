//
//  CharacterListHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import AppCore

//MARK: - CharacterListHandler protocol
protocol CharacterListHandlerProtocol {
    var characters: [Person] { get }
    var lastPageWasLoaded: Bool { get }

    func loadNextPage() async throws
}

//MARK: - CharacterListHandler
class CharacterListHandler: CharacterListHandlerProtocol {
    private(set) var characters: [Person] = []
    private(set) var lastPageWasLoaded = false
    private let apiHandler: APIHandlerProtocol
    private var currentPage: Int = 0
    private var count: Int? = nil

    init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }

    func loadNextPage() async throws {
        currentPage += 1
        if currentPage > count ?? 1 {
            return
        }
        let page = try await apiHandler.getCharactersPage(page: currentPage)
        count = page.info.pages
        characters.append(contentsOf: page.results)
        lastPageWasLoaded = currentPage >= (count ?? 1)
    }
}
