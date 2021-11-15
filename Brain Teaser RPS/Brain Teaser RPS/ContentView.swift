//
//  ContentView.swift
//  Brain Teaser RPS
//
//  Created by Alex Diaz on 11/13/21.
//

import SwiftUI

struct ContentView: View {
    
    let possibleMoves = ["Rock 🗿", "Paper 🧻", " Scissors ✂️"]
    var appChoice: Int {
        randomMove
    }
    @State private var randomMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var scoreShowing = false
    
    @State private var playerScore = 0
    @State private var questionsAsked = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack(spacing: 15) {
                    VStack {
                        VStack {
                        Text("Instructions: This is a Rock, Paper, Scissors brain teaser. To score points you must win when the app says win and lose when the app says to lose. If you win when the app says to lose you will lose a point and vice versa.")
                                .padding(.horizontal, 20)
                                .padding(.top, 15)
                                .foregroundStyle(.secondary)
                                .font(.subheadline.weight(.heavy))
                        Text("Good Luck!")
                                .multilineTextAlignment(.center)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                            }
                        Spacer()
                        Text(possibleMoves[randomMove])
                            .font(.largeTitle.weight(.semibold))
                            .padding()
                                if shouldWin {
                                    Text("Win")
                                } else {
                                    Text("Lose")
                                }
                        Spacer()
                        Spacer()
                        Text("What's Your Move?")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        }
                    HStack {
                        ForEach(0..<3) { choice in
                            Button(action: { moveTapped(choice: choice, appChoice: appChoice, shouldWin: shouldWin)}) {
                                Text(possibleMoves[choice])
                            }
                            .alert(isPresented: $scoreShowing) {
                                Alert(title: Text("Great Game!"), message:
                                Text("Your final score is \(playerScore)"),
                                      dismissButton: .default(Text("Want to play again?")) {
                                    playerScore = 0 })
                            }
                        }
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("Your score is \(playerScore)!")
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(.regularMaterial)
                    }
                }
                    .navigationBarTitle("Brain Teaser Game", displayMode: .inline)
            }
        }
    
    
    func whoWins(computer cguess: Int, player pguess: Int, shouldWin: Bool) -> Bool {
        shouldWin ? ((cguess + 1) % 3) == pguess : cguess == ((pguess + 1) % 3)
    }
    
    func moveTapped(choice: Int, appChoice: Int, shouldWin: Bool) {
        if whoWins(computer: appChoice, player: choice, shouldWin: shouldWin) {
            playerScore += 1
            questionsAsked += 1
        } else {
            playerScore -= 1
            questionsAsked += 1
        }
        reStart()
        if questionsAsked >= 10 {
            questionsAsked = 0
            scoreShowing = true
        }
    }
    
    func reStart() {
        randomMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
