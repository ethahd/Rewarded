//
//  RewardView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/21/25.
//

import SwiftUI
import SwiftData

struct WalletView: View {
    @Query(sort: \CreditCard.name) var cards: [CreditCard]
    @Environment(\.modelContext) private var context

    @State private var showAddCardSheet = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(cards) { card in
                    CardView(card: card)
                }
            }
            .navigationTitle("My Wallet")
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        showAddCardSheet = true
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "plus.circle.fill")
                            Text("Add Card")
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.blue.opacity(0.2))
                        .foregroundColor(.blue)
                        .clipShape(Capsule())
                        
                    }
                    
                }
            }
            .sheet(isPresented: $showAddCardSheet) {
                AddCard()
                    .presentationBackground(.thickMaterial)
                    .presentationDetents([.medium, .large])
                    .presentationBackgroundInteraction(.enabled(upThrough: .large))
                    .presentationCornerRadius(21)
            }
        }
    }
}

#Preview {
    WalletView()
}
