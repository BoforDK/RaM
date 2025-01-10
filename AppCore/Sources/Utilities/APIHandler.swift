//
//  APIHandler.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

// MARK: - APIHandler protocol

public protocol APIHandlerProtocol {
    func getCharactersPage(page: Int) async throws -> ApiCharactersPage
    func getSearchPage(name: String, page: Int) async throws -> ApiCharactersPage
    func getCharacters(ids: [Int]) async throws -> [ApiPerson]
    func getCharacter(id: Int) async throws -> ApiPerson
}

// MARK: - APIHandler

public class APIHandler: APIHandlerProtocol {

    let networkAPI: NetworkAPIProtocol

    public init(networkAPI: NetworkAPIProtocol) {
        self.networkAPI = networkAPI
    }

    public func getCharactersPage(page: Int) async throws -> ApiCharactersPage {
        try await getCharactersPage(
            source: LinkSource.charactersPage,
            page: page
        )
    }

    public func getSearchPage(
        name: String,
        page: Int
    ) async throws -> ApiCharactersPage {
        try await getCharactersPage(
            source: LinkSource.characters,
            page: page,
            queryItems: [
                .init(
                    name: LinkSource.filterByName,
                    value: name.replacingOccurrences(of: " ", with: "+")
                )
            ]
        )
    }

    public func getCharacters(ids: [Int]) async throws -> [ApiPerson] {
        if ids.count == 1 {
            return [try await getCharacter(id: ids[0])]
        } else if ids.isEmpty {
            return []
        } else {
            var stringIds = ids
                .map(String.init)
                .joined(separator: ",")

            let stringURL = "\(LinkSource.characters)/\(stringIds)"

            guard let url = URL(string: stringURL) else {
                throw URLError(.badServerResponse)
            }

            let characters = try await networkAPI.sendGetRequest(
                type: [ApiPerson].self,
                url: url
            )

            return characters
        }
    }

    public func getCharacter(id: Int) async throws -> ApiPerson {
        let stringURL = "\(LinkSource.characters)/\(id)"

        guard let url = URL(string: stringURL) else {
            throw URLError(.badServerResponse)
        }

        let character = try await networkAPI.sendGetRequest(
            type: ApiPerson.self,
            url: url
        )

        return character
    }

    private func getCharactersPage(
        source: String,
        page: Int,
        queryItems: [URLQueryItem] = []
    ) async throws -> ApiCharactersPage {
        guard var url = URL(string: source) else {
            throw URLError(.badServerResponse)
        }

        url.append(queryItems: [.init(name: LinkSource.pageParam, value: "\(page)")])
        url.append(queryItems: queryItems)
        let charactersPage = try await networkAPI.sendGetRequest(
            type: ApiCharactersPage.self,
            url: url
        )

        return charactersPage
    }
}
