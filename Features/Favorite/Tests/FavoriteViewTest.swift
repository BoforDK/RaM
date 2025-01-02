//
//  FavoriteViewTest.swift
//  Favorite
//
//  Created by Alexander Grigorov on 02.01.2025.
//

import SnapshotTesting
import XCTest
import UIKit
import SwiftUI

@testable import App

final class FavoriteViewTest: XCTestCase {
    public func test_snapshot() {
        let view = FavoriteView(
            viewModel: FavoriteViewModelMock()
        )

        let viewController = UIHostingController(rootView: view)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13))
    }
}
