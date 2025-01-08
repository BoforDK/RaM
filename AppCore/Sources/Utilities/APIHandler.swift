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
            source: LinkSource.characters,
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
            var stringIds = ids
                .map(String.init)
                .joined(separator: ",")

            if !stringIds.isEmpty {
                stringIds.removeFirst()
            }

            let stringURL = "\(LinkSource.characters)/\(stringIds)"

            guard let url = URL(string: stringURL) else {
                throw URLError(.badServerResponse)
            }

            let characters = try await networkAPI.sendGetRequest(
                type: [Person].self,
                url: url
            )

            return characters
        }
    }

    public func getCharacter(id: Int) async throws -> Person {
        let stringURL = "\(LinkSource.characters)/\(id)"

        guard let url = URL(string: stringURL) else {
            throw URLError(.badServerResponse)
        }

        let character = try await networkAPI.sendGetRequest(
            type: Person.self,
            url: url
        )

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
        let charactersPage = try await networkAPI.sendGetRequest(
            type: CharactersPage.self,
            url: url
        )

        return charactersPage
    }
}
