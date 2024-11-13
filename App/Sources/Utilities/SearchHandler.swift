//
//  SearchHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import AppCore

// MARK: - SearchListHandler protocol

protocol SearchHandlerProtocol {
    var characters: [Person] { get }
    var lastPageWasLoaded: Bool { get }

    func setSearchText(searchText: String) async throws
    func loadNextPage() async throws
}

// MARK: - SearchListHandler

class SearchHandler: SearchHandlerProtocol {
    private(set) var characters: [Person] = []
    private(set) var lastPageWasLoaded = false
    private let apiHandler: APIHandlerProtocol
    private var searchText: String = ""
    private var oldSearchText: String = ""
    private var currentPage: Int = 0
    private var count: Int? = nil

    init(apiHandler: APIHandlerProtocol) {
        self.apiHandler = apiHandler
    }

    func setSearchText(searchText: String) async throws {
        if searchText == self.searchText {
            return
        }
        reset()
        self.searchText = searchText

        try await loadNextPage()
    }

    func loadNextPage() async throws {
        currentPage += 1
        if currentPage > count ?? 1 {
            return
        }
        if searchText.isEmpty {
            characters = []
            lastPageWasLoaded = true
        } else {
            let text = searchText.replacingOccurrences(of: " ", with: "+")
            if !text.isEmpty {
                let page = try? await apiHandler.getSearchPage(name: text, page: currentPage)
                count = page?.info.count
                characters.append(contentsOf: page?.results ?? [])
            }
            lastPageWasLoaded = currentPage >= (count ?? 1)
        }
        oldSearchText = searchText
    }

    private func reset() {
        characters = []
        lastPageWasLoaded = false
        oldSearchText = ""
        currentPage = 0
        count = nil
    }
}

