//
//  ContentView.swift
//  PhotosPro
//
//  Created by Кирилл Архипов on 14.10.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundMain.ignoresSafeArea()
                TabView (selection: $selectedTab) {
                    PortfolioView()
                        .tag(0)
                    IdeasView()
                        .tag(1)
                    ClientsView()
                        .tag(2)
                    TasksView()
                        .tag(3)
                    FinanceView()
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserService())
}
