//
//  NetworkAPI.swift
//  RaM
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

// MARK: – NetworkApi protocol
protocol NetworkAPIProtocol {
    func sendRequest<T: Decodable>(type: T.Type, _ request: URLRequest) async throws -> T

    func sendRequest(_ request: URLRequest) async throws -> Data

    func createPostRequest<T: Encodable>(url: URL, object: T) throws -> URLRequest

    func createGetRequest(url: URL) throws -> URLRequest
}

// MARK: - NetworkApi
class NetworkAPI: NetworkAPIProtocol {
    private var session: URLSession
    private var allHTTPHeaderFields = ["Content-Type": "application/json"]

    init(session: URLSession, allHTTPHeaderFields: [String: String]) {
        self.session = session
        self.allHTTPHeaderFields = allHTTPHeaderFields
    }

    init(timeoutIntervalForRequest: TimeInterval = 10.0,
                  timeoutIntervalForResource: TimeInterval = 10.0,
                  allHTTPHeaderFields: [String: String] = ["Content-Type": "application/json"]
    ) {
        self.allHTTPHeaderFields = allHTTPHeaderFields
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = timeoutIntervalForRequest
        sessionConfig.timeoutIntervalForResource = timeoutIntervalForResource
        session = URLSession(configuration: sessionConfig)
    }

    func sendRequest<T: Decodable>(type: T.Type, _ request: URLRequest) async throws -> T {
        let data = try await sendRequest(request)
        let decodedData = try JSONDecoder().decode(T.self, from: data)
        return decodedData
    }

    func sendRequest(_ request: URLRequest) async throws -> Data {
        let data: Data!
        let response: URLResponse!
        (data, response) = try await session.data(for: request)
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode != 200 {
            throw URLError(.badServerResponse, userInfo: ["Status code": statusCode])
        } else if (response as? HTTPURLResponse)?.statusCode == nil {
            throw URLError(.badServerResponse)
        }
        return data
    }

    func createPostRequest<T: Encodable>(url: URL, object: T) throws -> URLRequest {
        let jsonData = try JSONEncoder().encode(object)
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.allHTTPHeaderFields = allHTTPHeaderFields
        request.httpBody = jsonData
        return request
    }

    func createGetRequest(url: URL) throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = allHTTPHeaderFields
        return request
    }

    enum HTTPMethod: String {
        case post
        case get
    }
}
