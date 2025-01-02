//
//  Untitled.swift
//  AppTests
//
//  Created by Alexander Grigorov on 01.01.2025.
//

import SnapshotTesting
import XCTest
import UIKit
import SwiftUI

@testable import App

final class CharactersViewTest: XCTestCase {
    public func test_snapshot() {
        let view = CharactersView(
            viewModel: CharactersViewModelMock()
        )

        let viewController = UIHostingController(rootView: view)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13))
    }

    public func test_snapshot_search() {
        let view = CharactersView(
            viewModel: CharactersViewModelMock(
                searchText: "Some search text",
                initIsSearching: true
            )
        )

        let viewController = UIHostingController(rootView: view)

        assertSnapshot(of: viewController, as: .image(on: .iPhone13))
    }
}
