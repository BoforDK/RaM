//
//  NetworkAPI.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

// MARK: – NetworkApi protocol

public protocol NetworkAPIProtocol {
    func sendGetRequest<T: Decodable>(type: T.Type, url: URL) async throws -> T
}

extension NetworkAPIProtocol {
    func sendGetRequest<T: Decodable>(type: T.Type = T.self, url: URL) async throws -> T {
        try await sendGetRequest(type: type, url: url)
    }
}

// MARK: - NetworkApi

public class NetworkAPI: NetworkAPIProtocol {
    private var session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func sendGetRequest<T: Decodable>(type: T.Type, url: URL) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue

        return try await sendRequest(request)
    }

    private func sendRequest<T: Decodable>(
        type: T.Type = T.self,
        _ request: URLRequest
    ) async throws -> T {
        let data = try await sendRequest(request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)

        return decodedData
    }

    private func sendRequest(_ request: URLRequest) async throws -> Data {
        let (data, _) = try await session.data(for: request)

        return data
    }

    // MARK: - HTTPMethod

    public enum HTTPMethod: String {
        case post
        case get
    }
}
