//
//  Player.swift
//  PokerV2
//
//  Created by Eric Wong Liu on 2024-06-15.
//

import Foundation
import SwiftData

@Model
class Player {
    let name: String
    var buyinCount: Int = 0
    var chipCount: Double = 0
    
    var totalCount: Double {
        if buyinCount > 0 {
            return chipCount - (GameInfo.shared.buyinValue * Double(buyinCount) +
                                GameInfo.shared.bountyValue)
        } else {
            return 0
        }
    }
    
    init(name: String, buyinCount: Int, chipCount: Double) {
        self.name = name
        self.buyinCount = buyinCount
        self.chipCount = chipCount
    }
    
    init(name:String) {
        self.name = name
    }
}
