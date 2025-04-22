//
//  HomeView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the Home Screen!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
