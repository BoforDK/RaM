//
//  FloatingBar.swift
//  AppUI
//
//  Created by Alexander Grigorov on 26.11.2024.
//

import SwiftUI

private struct FloatingBar<BarContent: View>: ViewModifier {
    @ViewBuilder var barContent: () -> BarContent

    @State var showTabBar: Bool = true
    @State var tabBarIconSize: CGFloat = 0

    let tabBarHorizontalPadding: CGFloat = 30
    let tabBarVerticalPadding: CGFloat = 15
    let tabBarBotOffset: CGFloat = 25
    let tabBarShadowSize: CGFloat = 10

    public init(@ViewBuilder barContent: @escaping () -> BarContent) {
        self.barContent = barContent
    }

    func body(content: Content) -> some View {
        content
            .environment(\.showTabBar, tabBar)
            .overlay {
                overlayBar
            }
    }

    var overlayBar: some View {
        HStack(spacing: 40) {
            barContent()
        }
        .padding(.horizontal, tabBarHorizontalPadding)
        .padding(.vertical, tabBarVerticalPadding)
        .background {
            Capsule()
                .fill(Color.listItem)
                .shadow(color: .background, radius: tabBarShadowSize)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.bottom, tabBarBotOffset)
        .readSize {
            tabBarIconSize = $0.width
        }
        .offset(y: showTabBar ? 0 : tabBarIconSize)
        .ignoresSafeArea(edges: .bottom)
        .animation(.spring, value: showTabBar)
    }

    func tabBar(show: Bool) {
        guard showTabBar != show else {
            return
        }

        showTabBar = show
    }
}

public extension View {
    func floatingBar<BarContent: View>(
        @ViewBuilder barContent: @escaping () -> BarContent
    ) -> some View {
        modifier(
            FloatingBar(barContent: barContent)
        )
    }
}
