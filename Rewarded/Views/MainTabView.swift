//
//  MainTabView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import SwiftUI

struct MainTabView: View {
    @State var selection: Int = 0
    
    var body: some View {
        TabView (selection: $selection) {
            Tab ("Home", systemImage: "house.fill", value: 0) {
                HomeView()
            }
            Tab ("Wallet", systemImage: "wallet.pass.fill", value: 1) {
                WalletView()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView()
}
