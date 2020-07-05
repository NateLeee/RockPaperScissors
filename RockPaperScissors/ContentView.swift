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
                Text("Game Counter: \(gameCounter)")
                Text("Score: \(score)")
                Text("Computer Move: \(currentMove)")
                Text("And you should: \(rule == .ToWin ? "WIN" : "LOSE")!")
            }
            
            HStack {
                ForEach(ContentView.moves, id: \.self) { move in
                    Button(action: {
                        switch self.currentMove {
                        case "Rock":
                            if (move == "Paper" && self.rule == .ToWin) {
                                self.score += 1
                            } else if (self.rule == .ToLose) {
                                self.score += 1
                            } else if (move == "Rock") {
                            } else {
                                self.score -= 1
                            }
                            
                            
                        case "Paper":
                            if (move == "Scissors" && self.rule == .ToWin) {
                                self.score += 1
                            } else if (self.rule == .ToLose) {
                                self.score += 1
                            } else if (move == "Paper") {
                            } else {
                                self.score -= 1
                            }
                            
                            
                        case "Scissors":
                            if (move == "Rock" && self.rule == .ToWin) {
                                self.score += 1
                            } else if (self.rule == .ToLose) {
                                self.score += 1
                            } else if (move == "Scissors") {
                            } else {
                                self.score -= 1
                            }
                            
                        default: break
                        }
                        
                        // Refresh question
                        self.currentMove = ContentView.moves[Int.random(in: 0..<3)]
                        self.rule = GameRule(rawValue: Int.random(in: 0...1))
                        
                        // Increment the game counter
                        self.gameCounter += 1
                        
                        
                    }) {
                        Text(move)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
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
    
    func referee() {
        
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
