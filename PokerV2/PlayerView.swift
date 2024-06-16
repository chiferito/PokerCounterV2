//
//  PlayerView.swift
//  Poker
//
//  Created by Eric Wong Liu on 2024-06-08.
//

import SwiftUI

struct PlayerView: View {
    @State private var player: Player
    @State private var chipCount: Double
    
    private var totalColor: Color {
        if player.totalCount > 0 {
            return Color.green
        } else if player.totalCount < 0 {
            return Color.red
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        HStack {
            Text(player.name)
                .frame(width:60)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            HStack{
                Text("\(player.buyinCount)")
                Button() {
                    player.buyinCount += 1
                } label: {
                    Image(systemName: "plus")
                }.buttonStyle(.borderless)
                Button() {
                    if player.buyinCount > 0 {
                        player.buyinCount -= 1
                    }
                }label: {
                    Image(systemName: "minus")
                }.buttonStyle(.borderless)
            }.frame(width:80)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .padding()
           
            TextField("", value: $chipCount, format: .number)
                .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .frame(width:60)
                .multilineTextAlignment(.center)
                .onSubmit {
                    player.chipCount=chipCount
                }
            
            if player.buyinCount > 0 {
                Text("\(player.totalCount, specifier:"%.2f")")
                    .foregroundStyle(totalColor)
                    .frame(width:60)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .padding()
            } else {
                Text("\(0)")
                    .frame(width:60)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    .padding()
                    
            }
                
        }
        
    }
    
    init(player: Player) {
        self.player = player
        self.chipCount = player.chipCount
    }
}

#Preview {
    PlayerView(player: Player(name: "Eric"))
        .modelContainer(for: [Player.self, GameInfo.self], inMemory: true)
}
