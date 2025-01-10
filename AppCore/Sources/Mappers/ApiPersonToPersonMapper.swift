//
//  ApiPersonToPersonMapper.swift
//  AppCore
//
//  Created by Alexander Grigorov on 10.01.2025.
//

public struct ApiPersonToPersonMapper {

    public init() {}

    public func map(from apiPersons: [ApiPerson]) -> [Person] {
        apiPersons.map(map(from:))
    }

    public func map(from apiPerson: ApiPerson) -> Person {
        Person(
            id: apiPerson.id,
            name: apiPerson.name,
            status: Status(rawValue: apiPerson.status) ?? .unknown,
            species: apiPerson.species,
            type: apiPerson.type,
            gender: apiPerson.gender,
            origin: ApiLocationToLocationMapper().map(
                from: apiPerson.origin
            ),
            location: ApiLocationToLocationMapper().map(
                from: apiPerson.location
            ),
            image: apiPerson.image
        )
    }
}
