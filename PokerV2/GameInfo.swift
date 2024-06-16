//
//  GameInfo.swift
//  PokerV2
//
//  Created by Eric Wong Liu on 2024-06-15.
//

import Foundation
import SwiftData

@Model
class GameInfo {
    static let shared = GameInfo(buyinValue: ContentView.newBuyin, bountyValue: ContentView.newBounty)
    var buyinValue: Double
    var bountyValue: Double
    
    private init(buyinValue: Double, bountyValue: Double) {
        self.buyinValue = buyinValue
        self.bountyValue = bountyValue
    }
}
