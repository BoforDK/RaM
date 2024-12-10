//
//  ContainerExtensions.swift
//  App
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import Foundation
import Swinject

extension Container {

    static let shared = Container()

    @discardableResult
    func register<Service>(
        _ serviceType: Service.Type,
        name: ClassName? = nil,
        factory: @escaping (Resolver) -> Service
    ) -> ServiceEntry<Service> {
        return self.register(serviceType, name: name?.rawValue, factory: factory)
    }

    func resolve<Service>(
        _ serviceType: Service.Type,
        name: ClassName?
    ) -> Service? {
        return self.resolve(serviceType, name: name?.rawValue)
    }

    enum ClassName: String {
        case characterListHandler
        case searchHandler
        case favoriteHandler
    }
}
