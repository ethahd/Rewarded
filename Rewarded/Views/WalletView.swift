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
                .onDelete(perform: deleteCards)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("My Wallet")
                        .font(.largeTitle.bold())
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Color("Plat"), Color("Gold")]), startPoint: .top, endPoint: .bottom))
                }
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
    
    private func deleteCards(at offsets: IndexSet) {
        for index in offsets{
            context.delete(cards[index])
        }
    }
}

#Preview {
    WalletView()
}
