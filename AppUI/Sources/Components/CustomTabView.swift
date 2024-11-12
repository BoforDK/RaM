//
//  CustomTabView.swift
//  AppUI
//
//  Created by Alexander Grigorov on 26.01.2023.
//

import SwiftUI

public struct CustomTabView<C0, C1, TB1, TB2>: View
    where C0: View, C1: View, TB1: View, TB2: View
{
    @ViewBuilder var content: () -> TupleView<(C0, C1)>
    @ViewBuilder var tabBar: () -> TupleView<(TB1, TB2)>
    @State private var tabSelection = true
    @State private var showTabBar = true
    let tabBarIconSize: CGFloat = 40
    let tabBarHorizontalPadding: CGFloat = 30
    let tabBarVerticalPadding: CGFloat = 15
    let tabBarBotOffset: CGFloat = 25
    let tabBarShadowSize: CGFloat = 10
    
    public init(
        @ViewBuilder content: @escaping () -> TupleView<(C0, C1)>,
        @ViewBuilder tabBar: @escaping () -> TupleView<(TB1, TB2)>
    ) {
        self.content = content
        self.tabBar = tabBar
    }

    public var body: some View {
        TabView(selection: $tabSelection) {
            let value = content().value
            value.0
                .tag(true)
                .environment(\.showTabBar, tabBar)

            value.1
                .tag(false)
                .environment(\.showTabBar, tabBar)
        }
        .overlay {
            overlayBar
        }
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }

    private var overlayBar: some View {
        HStack(spacing: tabBarIconSize) {
            let tabValue = tabBar().value
            Button(action: {tabSelection = true}, label: {
                tabValue.0
                    .foregroundColor(tabSelection ? Color.blue : Color.accent)
                    .frame(width: tabBarIconSize, height: tabBarIconSize)
            })
            Button(action: {tabSelection = false}, label: {
                tabValue.1
                    .foregroundColor(!tabSelection ? Color.blue : Color.accent)
                    .frame(width: tabBarIconSize, height: tabBarIconSize)
            })
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
        .offset(y: showTabBar ? 0 : offsetToHide)
        .ignoresSafeArea(edges: .bottom)
    }

    private func tabBar(show: Bool) {
        if showTabBar == show {
            return
        }
        withAnimation(.spring()) {
            showTabBar = show
        }
    }
    
    private var offsetToHide: CGFloat {
        2 * tabBarVerticalPadding + tabBarIconSize + tabBarBotOffset + tabBarIconSize
    }
}
