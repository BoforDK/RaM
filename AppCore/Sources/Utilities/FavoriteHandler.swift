//
//  FavoriteHandler.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Combine

// MARK: - FavoriteHandler protocol

public protocol FavoriteHandlerProtocol {
    var favorites: CurrentValueSubject<[Person], Never> { get }
    var isError: Bool { get }

    @discardableResult
    func add(id: Int) -> Bool
    @discardableResult
    func delete(id: Int) -> Bool
    func contains(id: Int) -> Bool
    func retry()
}

// MARK: - FavoriteHandler

public class FavoriteHandler: FavoriteHandlerProtocol {

    private(set) public var favorites = CurrentValueSubject<[Person], Never>([])
    private(set) public var isError: Bool = false
    private let favoriteRepository: FavoriteRepository
    private var cancellable: AnyCancellable!
    private let apiHandler: APIHandler

    public init(favoriteRepository: FavoriteRepository, apiHandler: APIHandler) {
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
    public func add(id: Int) -> Bool {
        do {
            if !contains(id: id) {
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
    public func delete(id: Int) -> Bool {
        do {
            if contains(id: id) {
                try favoriteRepository.delete(id: Int64(id))
                return true
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    public func contains(id: Int) -> Bool {
        return favoriteRepository.findById(Int64(id)) != nil
    }

    public func retry() {
        getCharacter(
            ids: favoriteRepository.favorites.value.map { Int($0.id) }
        )
    }

    private func getCharacter(ids: [Int]) {
        Task {
            do {
                let characters = try await apiHandler.getCharacters(ids: ids)
                await setCharacters(characters: characters)
                isError = false
            } catch {
                isError = true
            }
        }
    }

    @MainActor
    private func setCharacters(characters: [Person]) {
        self.favorites.value = characters
    }
}
