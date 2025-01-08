//
//  ErrorState.swift
//  AppUI
//
//  Created by Alexander Grigorov on 08.01.2025.
//

import SwiftUI

private struct ErrorState: ViewModifier {
    var isError: Bool
    var action: (() -> Void)?

    init(
        isError: Bool,
        action: (() -> Void)? = nil
    ) {
        self.isError = isError
        self.action = action
    }

    func body(content: Content) -> some View {
        if isError {
            VStack {
                Text("Something went wrong")

                if let action {
                    Button(action: action) {
                        Text("Retry")
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            content
        }
    }
}

public extension View {
    func errorState(
        isError: Bool,
        action: (() -> Void)? = nil
    ) -> some View {
        modifier(ErrorState(isError: isError, action: action))
    }
}

