//
//  CardView.swift
//  Rewarded
//
//  Created by Ethan AK on 4/21/25.
//

import SwiftUI

struct CardView: View {
    let card: CreditCard
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(card.imageName)
                    .resizable()
                    .frame(width: 60, height: 40)
                    .cornerRadius(6)
                
                VStack(alignment: .leading) {
                    Text(card.name)
                        .font(.headline)
                    Text(card.issuer)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            HStack {
                ForEach(Array(card.rewardCategories.prefix(3)), id: \.key) { category, value in
                    Text("\(category.capitalized): \(formattedReward(value, type: card.type))")
                        .font(.caption2)
                        .padding(6)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(6)
                }
            }

        }
        .padding(.vertical, 8)
    }
    
    func formattedReward(_ value: Int, type: String) -> String {
        switch type.lowercased() {
        case "points":
            return "\(value)X points"
        case "cashback":
            let percent = Double(value) / 100.0
            return String(format: "%.2f%% cashback", percent)
        default:
            return "\(value)"
        }
    }

}

#Preview {
    //CardView(card: )
}
