//
//  RewardedApp.swift
//  Rewarded
//
//  Created by Ethan AK on 4/21/25.
//
import SwiftUI
import SwiftData


@main
struct RewardedApp: App {
    @State private var showLaunch = true
    @State private var shouldShowWelcome = false
    var body: some Scene {
        WindowGroup {
            ContentSelector(showLaunch: $showLaunch, shouldShowWelcome: $shouldShowWelcome)
        }
        .modelContainer(for: CreditCard.self)
    }
}

