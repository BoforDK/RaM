//
//  FavoriteHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Combine
import AppCore

// MARK: - FavoriteHandler protocol

protocol FavoriteHandlerProtocol {
    var favorites: CurrentValueSubject<[Character], Never> { get }

    @discardableResult
    func add(id: Int) -> Bool
    @discardableResult
    func delete(id: Int) -> Bool
    func contains(id: Int) -> Bool
}

// MARK: - FavoriteHandler

class FavoriteHandler: FavoriteHandlerProtocol {
    private let favoriteRepository: FavoriteRepository
    private(set) var favorites = CurrentValueSubject<[Character], Never>([])
    private var cancellable: AnyCancellable!
    private var apiHandler: APIHandler

    init(favoriteRepository: FavoriteRepository, apiHandler: APIHandler) {
        self.favoriteRepository = favoriteRepository
        self.apiHandler = apiHandler
        cancellable = favoriteRepository.favorites.sink { [weak self] cdCharacters in
            guard let strongSelf = self else {
                return
            }
            strongSelf.getCharacter(ids: cdCharacters.map { Int($0.id) })
        }
    }

    @discardableResult
    func add(id: Int) -> Bool {
        do {
            if favoriteRepository.findById(Int64(id)) == nil {
                try favoriteRepository.create(id: Int64(id))
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    @discardableResult
    func delete(id: Int) -> Bool {
        if favoriteRepository.findById(Int64(id)) != nil {
            return (try? favoriteRepository.delete(id: Int64(id))) != nil
        } else {
            return false
        }
    }

    func contains(id: Int) -> Bool {
        return favoriteRepository.findById(Int64(id)) != nil
    }

    private func getCharacter(ids: [Int]) {
        Task {
            do {
                let characters = try await apiHandler.getCharacters(ids: ids)
                await setCharacters(characters: characters)
            } catch {
                fatalError()
            }
        }
    }

    @MainActor
    private func setCharacters(characters: [Character]) {
        self.favorites.value = characters
    }
}
