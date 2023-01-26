//
//  MockSearchHandler.swift
//  RaMTests
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import XCTest
@testable import RaM

final class MockSearchHandler: SearchHandlerProtocol {
    @Stubbed var characters: [Character]
    @Stubbed var lastPageWasLoaded: Bool
    var setSearchTextStub = Stub<String, Void>()
    var loadNextPageStub = Stub<Void, Void>()

    init(characters: [Character], lastPageWasLoaded: Bool) {
        self.characters = characters
        self.lastPageWasLoaded = lastPageWasLoaded
    }

    func setSearchText(searchText: String) async throws {
        setSearchTextStub.call(with: searchText)
    }

    func loadNextPage() async throws {
        loadNextPageStub.call()
    }
}
