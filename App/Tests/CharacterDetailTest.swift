//
//  CharacterDetailTest.swift
//  AppTests
//
//  Created by Alexander Grigorov on 02.01.2025.
//

import SnapshotTesting
import XCTest
import UIKit
import SwiftUI

@testable import App

final class CharacterDetailViewTest: XCTestCase {
    public func test_snapshot() {
        let view = CharacterDetailView(
            viewModel: CharacterDetailViewModelMock()
        )

        let viewController = UIHostingController(rootView: view)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13))
    }
}
