//
//  APIHandler.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

// MARK: - APIHandler protocol

public protocol APIHandlerProtocol {
    func getCharactersPage(page: Int) async throws -> CharactersPage
    func getSearchPage(name: String, page: Int) async throws -> CharactersPage
    func getCharacters(ids: [Int]) async throws -> [Person]
    func getCharacter(id: Int) async throws -> Person
}

// MARK: - APIHandler

public class APIHandler: APIHandlerProtocol {

    let networkAPI: NetworkAPIProtocol

    public init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    public func getCharactersPage(page: Int) async throws -> CharactersPage {
        try await getCharactersPage(
            source: LinkSource.charactersPage,
            page: page
        )
    }

    public func getSearchPage(
        name: String,
        page: Int
    ) async throws -> CharactersPage {
        try await getCharactersPage(
            source: LinkSource.filter,
            page: page,
            queryItems: [
                .init(name: LinkSource.filterByName, value: name)
            ]
        )
    }

    public func getCharacters(ids: [Int]) async throws -> [Person] {
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
            let characters = try await networkAPI.sendRequest(type: [Person].self, request)

            return characters
        }
    }

    public func getCharacter(id: Int) async throws -> Person {
        let stringURL = "\(LinkSource.characters)/\(id)"

        guard let url = URL(string: stringURL) else {
            throw URLError(.badServerResponse)
        }

        let request = try networkAPI.createGetRequest(url: url)
        let character = try await networkAPI.sendRequest(type: Person.self, request)

        return character
    }

    private func getCharactersPage(
        source: String,
        page: Int,
        queryItems: [URLQueryItem] = []
    ) async throws -> CharactersPage {
        guard var url = URL(string: source) else {
            throw URLError(.badServerResponse)
        }

        url.append(queryItems: [.init(name: LinkSource.pageParam, value: "\(page)")])
        url.append(queryItems: queryItems)
        let request = try networkAPI.createGetRequest(url: url)
        let charactersPage = try await networkAPI.sendRequest(
            type: CharactersPage.self,
            request
        )

        return charactersPage
    }
}
