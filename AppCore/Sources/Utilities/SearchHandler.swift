//
//  SearchHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation

// MARK: - SearchListHandler protocol

public protocol SearchHandlerProtocol {
    var characters: [Person] { get }
    var lastPageWasLoaded: Bool { get }

    func setSearchText(searchText: String) async throws
    func loadNextPage() async throws
}

// MARK: - SearchListHandler

public class SearchHandler: SearchHandlerProtocol {
    private(set) public var characters: [Person] = []
    private(set) public var lastPageWasLoaded = false
    private let apiHandler: APIHandlerProtocol
    private var searchText: String = ""
    private var count: Int = 0

    public init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }

    public func setSearchText(searchText: String) async throws {
        if searchText == self.searchText {
            return
        }
        reset()
        self.searchText = searchText

        try await loadNextPage()
    }

    public func loadNextPage() async throws {
        if
            characters.count > 0,
            characters.count >= count
        {
            return
        }

        if searchText.isEmpty {
            characters = []
            lastPageWasLoaded = true
        } else {
            if
                !searchText.isEmpty
            {
                let page = try await apiHandler.getSearchPage(
                    name: searchText,
                    page: characters.count + 1
                )
                if
                    page.error == nil,
                    let info = page.info,
                    let results = page.results
                {
                    count = info.count
                    characters.append(
                        contentsOf: ApiPersonToPersonMapper().map(from: results)
                    )
                } else if page.error == .emptyResults {
                    return
                } else if let error = page.error {
                    throw error
                } else {
                    throw URLError(.unknown)
                }
            }
            lastPageWasLoaded = characters.count >= count
        }
    }

    private func reset() {
        characters = []
        lastPageWasLoaded = false
        count = 0
    }
}
