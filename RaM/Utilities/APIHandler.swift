//
//  APIHandler.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

//MARK: - APIHandler protocol
protocol APIHandlerProtocol {
    func getCharactersPage(page: Int) async throws -> CharactersPage
    func getSearchPage(name: String, page: Int) async throws -> CharactersPage
    func getCharacters(ids: [Int]) async throws -> [Character]
    func getCharacter(id: Int) async throws -> Character
}

//MARK: - APIHandler
class APIHandler: APIHandlerProtocol {
    let networkAPI: NetworkAPIProtocol

    //MARK: Public
    init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    func getCharactersPage(page: Int) async throws -> CharactersPage {
        try await getCharactersPage(source: LinkSource.charactersPage, page: page)
    }

    func getSearchPage(name: String, page: Int) async throws -> CharactersPage {
        try await getCharactersPage(source: LinkSource.filter,
                                    page: page,
                                    queryItems: [.init(name: LinkSource.filterByName, value: name)])
    }

    func getCharacters(ids: [Int]) async throws -> [Character] {
        if ids.count == 1 {
            return [try await getCharacter(id: ids[0])]
        } else if ids.isEmpty {
            return []
        } else {
            var stringIds = ids.reduce("", {"\($0),\($1)"})
            if !stringIds.isEmpty {
                stringIds.removeFirst()
            }
            let stringURL = "\(LinkSource.characters)/\(stringIds)"
            guard let url = URL(string: stringURL) else {
                throw URLError(.badServerResponse)
            }
            let request = try networkAPI.createGetRequest(url: url)
            let characters = try await networkAPI.sendRequest(type: [Character].self, request)
            return characters
        }
    }

    func getCharacter(id: Int) async throws -> Character {
        let stringURL = "\(LinkSource.characters)/\(id)"
        guard let url = URL(string: stringURL) else {
            throw URLError(.badServerResponse)
        }
        let request = try networkAPI.createGetRequest(url: url)
        let character = try await networkAPI.sendRequest(type: Character.self, request)
        return character
    }

    //MARK: Private
    private func getCharactersPage(source: String,
                                   page: Int,
                                   queryItems: [URLQueryItem] = []) async throws -> CharactersPage {
        guard var url = URL(string: source) else {
            throw URLError(.badServerResponse)
        }
        url.append(queryItems: [.init(name: LinkSource.pageParam, value: "\(page)")])
        url.append(queryItems: queryItems)
        let request = try networkAPI.createGetRequest(url: url)
        let charactersPage = try await networkAPI.sendRequest(type: CharactersPage.self, request)
        return charactersPage
    }
}
