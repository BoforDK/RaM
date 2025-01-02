//
//  CharacterListHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation

//MARK: - CharacterListHandler protocol
public protocol CharacterListHandlerProtocol {
    var characters: [Person] { get }
    var lastPageWasLoaded: Bool { get }

    func loadNextPage() async throws
}

//MARK: - CharacterListHandler
public class CharacterListHandler: CharacterListHandlerProtocol {

    private(set) public var characters: [Person] = []
    private(set) public var lastPageWasLoaded = false
    private let apiHandler: APIHandlerProtocol
    private var currentPage: Int = 0
    private var count: Int? = nil

    public init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }

    public func loadNextPage() async throws {
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
