//
//  RaMApp.swift
//  RaM
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI

@main
struct RaMApp: App {
    init() {
        SwinjectInit.initConteiner()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
