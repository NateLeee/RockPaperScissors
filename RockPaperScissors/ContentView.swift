//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Nate Lee on 7/5/20.
//  Copyright © 2020 Nate Lee. All rights reserved.
//

import SwiftUI

enum GameRule: Int {
    case ToWin = 0
    case ToLose
}

struct ContentView: View {
    static let moves = ["Rock", "Paper", "Scissors"]
    static let winningDic = ["Rock": "Paper", "Paper": "Scissors", "Scissors": "Rock"] // Pre-set this rule book.
    
    @State private var currentMove: String = moves[Int.random(in: 0..<3)]
    @State private var rule = GameRule(rawValue: Int.random(in: 0...1))
    @State private var score: Int = 0
    @State private var showingAlert = false
    @State private var gameCounter: Int = 0 {
        didSet {
            if (gameCounter == 10) {
                // Try to invoke a func, which is to show an alert.
                showAlert()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 27) {
            VStack(alignment: .leading, spacing: 12) {
                // Text("Game Counter: \(gameCounter)") // Hide this!
                Text("Score: \(score)")
                Text("Computer's Move: \(currentMove)")
                Text("And you should: \(rule == .ToWin ? "WIN" : "LOSE")!")
            }
            
            HStack(spacing: 15) {
                ForEach(ContentView.moves, id: \.self) { move in
                    Button(action: {
                        // Logic goes here
                        if (move == ContentView.winningDic[self.currentMove] && self.rule == .ToWin) {
                            self.score += 1
                        } else if (move == self.currentMove) {
                            // Tight, do nothing
                        } else if (self.rule == .ToLose) {
                            self.score += 1
                        } else {
                            self.score -= 1
                        }
                        
                        // Refresh question
                        self.currentMove = ContentView.moves[Int.random(in: 0..<3)]
                        self.rule = GameRule(rawValue: Int.random(in: 0...1))
                        
                        // Increment the game counter
                        self.gameCounter += 1
                        
                    }) {
                        Text(move)
                            .frame(width: 68)
                            .padding()
                            .font(Font.body.bold())
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(9.0)
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Game Stats"), message: Text("Your score: \(self.score)"), dismissButton: .default(Text("👌"), action: {
                // Reset score
                self.score = 0
                self.gameCounter = 0
            }))
        }
    }
    
    func showAlert() {
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
