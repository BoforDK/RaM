//
//  ApiLocationToLocationMapper.swift
//  AppCore
//
//  Created by Alexander Grigorov on 10.01.2025.
//

public struct ApiLocationToLocationMapper {

    public init() {}

    public func map(from apiLocation: ApiLocation) -> Location {
        Location(name: apiLocation.name)
    }
}
