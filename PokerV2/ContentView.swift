//
//  ContentView.swift
//  PokerV2
//
//  Created by Eric Wong Liu on 2024-06-15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var players: [Player]
    
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @AppStorage("newBuyin") static var newBuyin: Double = 5
    @AppStorage("newBounty") static var newBounty: Double = 2
    @FocusState private var nameIsFocused: Bool
    
    var body: some View {
        NavigationStack{
            Text("Poker")
                .font(.largeTitle)
            HStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 120, height: 80)
                        .foregroundStyle(.tint)
                    VStack{
                        Text("Buy-in Value:")
                            .foregroundStyle(Color.white)
                        
                        TextField("Buy-in value", value: ContentView.$newBuyin, format: .number)
                            .border(Color.white)
                            .foregroundStyle(Color.white)
                            .frame(width:60)
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                GameInfo.shared.buyinValue = ContentView.newBuyin
                            }
                    }
                }.padding(.trailing,50)
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 120, height: 80)
                        .foregroundStyle(.tint)
                    VStack{
                        Text("Bounty Value:")
                            .foregroundStyle(Color.white)
                        TextField("Bounty Value", value: ContentView.$newBounty, format: .number)
                            .border(Color.white)
                            .foregroundStyle(Color.white)
                            .frame(width:60)
                            .multilineTextAlignment(.center)
                            .onSubmit {
                                GameInfo.shared.bountyValue = ContentView.newBounty
                            }
                    }
                }
            }
            List {
                Section() {
                    HStack {
                        Text("Name")
                            .bold()
                            .padding(.trailing,25)
                        Text("Buy-ins")
                            .bold()
                            .padding(.trailing,30)
                        Text("Chips")
                            .bold()
                            .padding(.trailing,30)
                        Text("Total")
                            .bold()
                            .padding(.trailing)
                        Spacer()
                    }
                }
                Section() {
                    ForEach(players) {player in
                        HStack {
                            
                            PlayerView(player: player)
                            Button(){
                                context.delete(player)
                            }label: {
                                Image(systemName: "person.fill.xmark")
                            }.foregroundColor(.red)
                                .buttonStyle(.borderless)
                        }
                    }
                    let numbers = players.map( {$0.totalCount }).reduce(0, +)
                    Text("Sum: \(numbers,specifier:"%.2f")")
                }
            }
            
        } .safeAreaInset(edge: .bottom) {

            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing:20) {
                Text("New player")
                    .font(.headline)
                HStack {
                    TextField("Name",text:$newName)
                        .textFieldStyle(.roundedBorder)
                        .focused($nameIsFocused)
                    Button("Add") {
                        if newName != "" {
                            let newPlayer = Player(name: newName)
                            context.insert(newPlayer)
                            newName=""
                            
                        }
                        nameIsFocused = false
                    }
                }.padding()
            }
        }.task {
            context.insert(Player(name:"Eric"))
            context.insert(Player(name:"Tony"))
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Player.self, GameInfo.self], inMemory: true)
}
