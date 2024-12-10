//
//  RaMApp.swift
//  App
//
//  Created by Alexander on 26.01.2023.
//

import SwiftUI
import AppUI
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var appFlowCoordinator = AppFlowCoordinator()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        SwinjectInit.initConteiner()

        window = UIWindow(frame: UIScreen.main.bounds)

        appFlowCoordinator.start(window: window)

        return true
    }
}
