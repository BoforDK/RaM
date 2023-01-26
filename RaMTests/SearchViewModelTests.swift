//
//  SearchViewModelTests.swift
//  RaMTests
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import XCTest
import Swinject
import Combine
@testable import RaM

final class CharacterSearchViewModelTests: XCTestCase {
    var mock: MockSearchHandler!
    var searchText = "text"
    var cancellables = Set<AnyCancellable>()
    var characters: [Character] = Array(defaultCharacter[0..<5])
    var characters2: [Character] = Array(defaultCharacter[5..<defaultCharacter.count])
    var lastPageWasLoaded = false

    override func setUpWithError() throws {
        try super.setUpWithError()
        mock = MockSearchHandler(characters: characters, lastPageWasLoaded: lastPageWasLoaded)
        Container.shared.register(SearchHandlerProtocol.self, name: .searchHandler) { _ in
            return self.mock
        }
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mock = nil
        Container.shared.removeAll()
        cancellables.removeAll()
    }

    func testInt_defaultInit_CallSomeMehtod() async throws {
        let vm = CharacterSearchViewModel(searchText: searchText)
        let setCharactersExp = XCTestExpectation()
        vm.$characters.dropFirst().sink { newValue in
            setCharactersExp.fulfill()
        }
        .store(in: &cancellables)
        let getCharactersExp = mock.$characters.getStub.expectationCall
        await Task {
            wait(for: [getCharactersExp, setCharactersExp], timeout: 1)
            XCTAssertEqual(mock.$characters.getStub.invocations.count, 1)
            XCTAssertEqual(mock.setSearchTextStub.invocations.count, 1)
            XCTAssertEqual(vm.characters.count, characters.count)
            XCTAssertTrue(isEquals(lhs: characters, rhs: vm.characters))
            XCTAssertEqual(mock.lastPageWasLoaded, vm.lastPageWasLoaded)
        }.value
    }

    func testInt_loadNext_loadNextPage() async throws {
        let vm = CharacterSearchViewModel(searchText: searchText)
        mock.characters += characters2
        mock.lastPageWasLoaded = false
        vm.loadNext()
        await Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            XCTAssertFalse(vm.lastPageWasLoaded)
            XCTAssertEqual(vm.characters.count, characters.count + characters2.count)
            XCTAssertTrue(isEquals(lhs: characters + characters2, rhs: vm.characters))
        }.value
    }

    func testInt_loadNext_NothingChanges() async throws {
        mock.lastPageWasLoaded = true
        let vm = CharacterSearchViewModel(searchText: searchText)
        vm.loadNext()
        await Task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            XCTAssertTrue(vm.lastPageWasLoaded)
            XCTAssertEqual(vm.characters.count, characters.count)
            XCTAssertTrue(isEquals(lhs: characters, rhs: vm.characters))
        }.value
    }

     private func isEquals(lhs: [Character], rhs: [Character]) -> Bool {
        guard lhs.count == rhs.count else {
            return false
        }
        for i in (0..<lhs.count) {
            guard   lhs[i].id == rhs[i].id &&
                    lhs[i].name == rhs[i].name &&
                    lhs[i].status == rhs[i].status &&
                    lhs[i].species == rhs[i].species &&
                    lhs[i].type == rhs[i].type &&
                    lhs[i].gender == rhs[i].gender &&
                    lhs[i].origin.name == rhs[i].origin.name &&
                    lhs[i].location.name == rhs[i].location.name &&
                    lhs[i].image == rhs[i].image else {
                return false
            }
        }
        return true
    }
}
