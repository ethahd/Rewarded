//
//  AddCard.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import SwiftUI
import SwiftData

struct AddCard: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var searchText: String = ""

    private let allAvailableCards: [CreditCard] = [
        CreditCard(name: "Amex Gold", issuer: "American Express", imageName: "AmexGold", rewardCategories: ["restaurants":4, "grocery":4, "flights": 3, "hotels": 2, "other": 1], type: "points"),
        CreditCard(name: "Capital One Venture", issuer: "Capital One", imageName: "Venture", rewardCategories: ["hotels": 5, "other": 2], type: "points"),
        CreditCard(name: "Citi Double Cash", issuer: "Citi", imageName: "CitiCard", rewardCategories: ["other": 2], type: "cashback"),
        CreditCard(name: "Discover It", issuer: "Discover", imageName: "Discover", rewardCategories: ["restaurant": 5, "grocery": 5, "gas": 5], type: "cashback"),
        CreditCard(name: "Apple Card", issuer: "Goldman Sachs", imageName: "AppleCard", rewardCategories: ["apple": 3,"grocery": 2, "other": 2], type: "cashback"),
        CreditCard(name: "Chase Sapphire Preferred", issuer: "Chase", imageName: "ChaseSapphire", rewardCategories: ["travel":4, "dining":3, "hotel":2], type: "points"),
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCards) { card in
                    Button {
                        addCard(card)
                    } label: {
                        CardView(card: card)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Cards")
            .navigationTitle("Add Card")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }

    var filteredCards: [CreditCard] {
        if searchText.isEmpty {
            return allAvailableCards
        } else {
            return allAvailableCards.filter {
                $0.name.localizedCaseInsensitiveContains(searchText) ||
                $0.issuer.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    private func addCard(_ card: CreditCard) {
        let newCard = CreditCard(
            name: card.name,
            issuer: card.issuer,
            imageName: card.imageName,
            rewardCategories: card.rewardCategories,
            type: card.type
        )
        context.insert(newCard)
        dismiss()
    }
}
