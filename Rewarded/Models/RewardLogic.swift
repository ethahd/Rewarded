//
//  RewardLogic.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import Foundation

class RewardCalculator {
    static func bestCards(for businessCategories: [String], from wallet: [CreditCard]) -> [(card: CreditCard, reward: String)] {
        var matches: [(card: CreditCard, value: Int)] = []

        for card in wallet {
            var bestValue: Int? = nil

            // Step 1: Try to match categories directly
            for category in businessCategories {
                for (rewardCategory, value) in card.rewardCategories {
                    if category.lowercased().contains(rewardCategory.lowercased()) {
                        bestValue = max(bestValue ?? 0, value)
                    }
                }
            }

            // Step 2: If no match, use "other" category as fallback
            if bestValue == nil, let otherValue = card.rewardCategories["other"] {
                bestValue = otherValue
            }

            if let value = bestValue {
                matches.append((card: card, value: value))
            }
        }

        let sorted = matches.sorted { $0.value > $1.value }

        return sorted.map { card, value in
            let rewardString = formatReward(value, type: card.type)
            return (card, rewardString)
        }
    }

    private static func formatReward(_ value: Int, type: String) -> String {
        switch type.lowercased() {
        case "points":
            return "\(value)X points"
        case "cashback":
            let percent = Double(value) / 100.0
            return String(format: "%.2f%%", percent)
        default:
            return "\(value)"
        }
    }
}

