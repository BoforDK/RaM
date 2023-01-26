//
//  EnvironmentValues+.swift
//  RaM
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

private struct CustomTabBarKey: EnvironmentKey {
    static let defaultValue: (Bool) -> Void = {_ in}
}

extension EnvironmentValues {
    var showTabBar: (Bool) -> Void {
        get { self[CustomTabBarKey.self] }
        set { self[CustomTabBarKey.self] = newValue }
    }
}
