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
    private var count: Int = 0

    public init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }

    public func loadNextPage() async throws {
        if
            currentPage > 0,
            currentPage >= count
        {
            return
        }

        let page = try await apiHandler.getCharactersPage(page: currentPage + 1)
        currentPage += 1
        count = page.info.pages
        characters.append(contentsOf: page.results)
        lastPageWasLoaded = currentPage >= count
    }
}
