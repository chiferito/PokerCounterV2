//
//  PokerV2App.swift
//  PokerV2
//
//  Created by Eric Wong Liu on 2024-06-15.
//

import SwiftUI
import SwiftData

@main
struct PokerV2App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Player.self, GameInfo.self])
        }
    }
}
