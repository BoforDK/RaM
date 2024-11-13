//
//  OffsetModifier.swift
//  AppUI
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

public struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    public let coordinateSpaceName: String
    
    public init(
        offset: Binding<CGFloat>,
        coordinateSpaceName: String
    ) {
        self._offset = offset
        self.coordinateSpaceName = coordinateSpaceName
    }

    public func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .named(coordinateSpaceName)).minY

                    Color.clear
                        .preference(key: OffsetKey.self, value: minY)
                }
                .onPreferenceChange(OffsetKey.self) { minY in
                    Task { @MainActor in
                        self.offset = minY
                    }
                }
            }
    }
}

public struct OffsetKey: PreferenceKey {
    public static var defaultValue: CGFloat = 0

    public static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
