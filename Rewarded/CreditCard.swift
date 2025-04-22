//
//  CreditCard.swift
//  Rewarded
//
//  Created by Ethan AK on 4/22/25.
//

import Foundation
import SwiftData

@Model
class CreditCard: Identifiable {
    var id: UUID
    var name: String
    var issuer: String
    var imageName: String
    var rewardCategories: [String:Int]
    var type: String

    init(name: String, issuer: String, imageName: String, rewardCategories: [String:Int], type: String) {
        self.id = UUID()
        self.name = name
        self.issuer = issuer
        self.imageName = imageName
        self.rewardCategories = rewardCategories
        self.type = type
    }
}

