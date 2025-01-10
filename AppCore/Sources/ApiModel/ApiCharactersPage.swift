//
//  ApiCharactersPage.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

public struct ApiCharactersPage: Decodable {

    public let info: ApiPageInfo?
    public let results: [ApiPerson]?
    public let error: LoadError?

    public init(
        info: ApiPageInfo?,
        results: [ApiPerson]?,
        error: LoadError?
    ) {
        self.info = info
        self.results = results
        self.error = error
    }

    public enum LoadError: String, Decodable, Error {
        case emptyResults = "There is nothing here"
        case unowned

        public init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(String.self)

            self = LoadError(rawValue: value) ?? .unowned
        }
    }
}
