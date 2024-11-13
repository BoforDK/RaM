//
//  PageInfo.swift
//  AppCore
//
//  Created by Alexander Grigorov on 24.01.2023.
//

import Foundation

public struct PageInfo: Decodable {
    
    public let count: Int
    public let pages: Int
    
    public init(
        count: Int,
        pages: Int
    ) {
        self.count = count
        self.pages = pages
    }
}
