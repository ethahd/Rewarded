//
//  ContentSelector.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import SwiftUI
import SwiftData

struct ContentSelector: View {
    @Query private var cards: [CreditCard]
    @Binding var showLaunch: Bool
    @Binding var shouldShowWelcome: Bool
    @State private var fadeOutLaunch = false

    var body: some View {
        Group {
            if shouldShowWelcome {
                WelcomeView()
            } else if showLaunch {
                ZStack {
                    Color.white.ignoresSafeArea()

                    Text("Rewarded.")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(Color("Gold"))
                        .opacity(fadeOutLaunch ? 0 : 1)
                }
                .onAppear {
                    withAnimation(.easeOut(duration: 3.0)) {
                        fadeOutLaunch = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation (.easeInOut(duration: 1.1)) {
                            showLaunch = false
                        }
                    }
                }
            } else {
                MainTabView()
            }
        }
        .onAppear {
            if cards.isEmpty {
                shouldShowWelcome = true
                showLaunch = false
            }
            else {
                showLaunch = true
            }
        }
    }
}



