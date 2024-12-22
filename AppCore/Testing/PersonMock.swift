//
//  PersonMock.swift
//  AppCore
//
//  Created by Alexander Grigorov on 22.12.2024.
//

public extension Person {
    static func mock(
        id: Int = 1,
        name: String = "Rick Sanchez",
        status: Status = .alive,
        species: String = "Human",
        type: String = "",
        gender: String = "Male",
        origin: Location = .init(name: "Earth (C-137)"),
        location: Location = .init(name: "Citadel of Ricks"),
        image: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg"
    ) -> Person {
        .init(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image
        )
    }
}

public extension [Person] {
    static var mock: [Person] {
        [
            .mock(),
            .mock(
                id: 2,
                name: "Morty Smith",
                status: .alive,
                species: "Human",
                type: "",
                gender: "Male",
                origin: .init(name: "unknown"),
                location: .init(name: "Citadel of Ricks"),
                image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg"
            ),
            .mock(
                id: 3,
                name: "Summer Smith",
                status: .alive,
                species: "Human",
                type: "",
                gender: "Female",
                origin: .init(name: "Earth (Replacement Dimension)"),
                location: .init(name: "Earth (Replacement Dimension)"),
                image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg"
            ),
            .mock(
                id: 4,
                name: "Beth Smith",
                status: .alive,
                species: "Human",
                type: "",
                gender: "Female",
                origin: .init(name: "Earth (Replacement Dimension)"),
                location: .init(name: "Earth (Replacement Dimension)"),
                image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg"
            ),
            .mock(
                id: 5,
                name: "Jerry Smith",
                status: .alive,
                species: "Human",
                type: "",
                gender: "Male",
                origin: .init(name: "Earth (Replacement Dimension)"),
                location: .init(name: "Earth (Replacement Dimension)"),
                image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg"
            ),
            .mock(
                id: 6,
                name: "Abadango Cluster Princess",
                status: .alive,
                species: "Alien",
                type: "",
                gender: "Female",
                origin: .init(name: "Abadango"),
                location: .init(name: "Abadango"),
                image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg"
            ),
            .mock(
                id: 7,
                name: "Abradolf Lincler",
                status: .unknown,
                species: "Human",
                type: "Genetic experiment",
                gender: "Male",
                origin: .init(name: "Earth (Replacement Dimension)"),
                location: .init(name: "Testicle Monster Dimension"),
                image: "https://rickandmortyapi.com/api/character/avatar/7.jpeg"
            ),
            .mock(
                id: 8,
                name: "Adjudicator Rick",
                status: .dead,
                species: "Human",
                type: "",
                gender: "Male",
                origin: .init(name: "unknown"),
                location: .init(name: "Citadel of Ricks"),
                image: "https://rickandmortyapi.com/api/character/avatar/8.jpeg"
            ),
            .mock(
                id: 9,
                name: "Agency Director",
                status: .dead,
                species: "Human",
                type: "",
                gender: "Male",
                origin: .init(name: "Earth (Replacement Dimension)"),
                location: .init(name: "Earth (Replacement Dimension)"),
                image: "https://rickandmortyapi.com/api/character/avatar/9.jpeg"
            ),
            .mock(
                id: 10,
                name: "Alan Rails",
                status: .dead,
                species: "Human",
                type: "Superhuman (Ghost trains summoner)",
                gender: "Male",
                origin: .init(name: "unknown"),
                location: .init(name: "Worldender's lair"),
                image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg"
            )
        ]
    }
}
