//
//  UIImageExtensions.swift
//  AppUI
//
//  Created by Alexander Grigorov on 10.12.2024.
//

import UIKit

public extension UIImage {
    static let favorite = UIImage(systemName: "star")
    static let persons = UIImage(systemName: "person.3")
    static let rick = UIImage(resource: .rick)
}

extension UIImage {
    func resize(targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
