//
//  ContentView.swift
//  Rock, Papers, and Scissors
//
//  Created by Luis Rivera Rivera on 2/11/24.
//

import SwiftUI

struct ProminentWhiteTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.white)
    }
}

struct MoveCard: View {
    let move: Move
    
    var moveEmoji: String {
        switch move {
        case .rock:
            "🪨"
        case .paper:
            "📄"
        case .scissors:
            "✂️"
        }
    }
    
    var body: some View {
        ZStack {
            Text(moveEmoji)
                .font(.system(size: 75))
        }
        .frame(width: 100, height: 100)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: 5.0))
    }
}

struct ComputerMoveView: View {
    let move: Move
    var moveEmoji: String {
        switch move {
        case .rock:
            "🪨"
        case .paper:
            "📄"
        case .scissors:
            "✂️"
        }
    }
    
    var body: some View {
        Text(moveEmoji)
        .font(.system(size: 75))    }
}

enum Move: String {
    case rock = "rock"
    case paper = "paper"
    case scissors = "scissors"
}

enum Outcome {
    case win, lose
}

extension View {
    func prominentWhiteTitle() -> some View {
        self.modifier(ProminentWhiteTitle())
    }
}

struct ContentView: View {
    let moves: [Move] = [.rock, .paper, .scissors]
    
    @State private var expectedOutcome: Outcome = .win
    @State private var round = 0
    @State private var computerMove = Int.random(in: 0...2)
    @State private var playerScore = 0
    
    @State private var isGameCompletedShowing = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [
                Color(red: 0.1, green: 0.2, blue: 0.45),
                Color(red: 0.76, green: 0.15, blue: 0.26)
            ],startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
                        
            VStack {
                Text("Brain Teaser")
                    .prominentWhiteTitle()
                
                Text("Round: \(round + 1)")
                    .prominentWhiteTitle()
                
                Spacer()
                
                Text("Computer Move:")
                    .prominentWhiteTitle()
                ComputerMoveView(move: moves[computerMove])
                
                Spacer()
                
                Group {
                    if expectedOutcome == .win {
                        HStack(spacing: 0) {
                            Text("Select move to ")
                                .foregroundStyle(.white)
                            Text("WIN")
                                .foregroundStyle(.green)
                        }
                    } else {
                        HStack(spacing: 0) {
                            Text("Select move to ")
                                .foregroundStyle(.white)
                            Text("LOSE")
                                .foregroundStyle(.red)
                        }
                    }
                }
                .font(.headline)

                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button {
                            checkMove(move)
                        } label: {
                            MoveCard(move: move)
                        }
                    }
                }
                
                Spacer()
                Spacer()

                Text("Score: \(playerScore)")
                    .prominentWhiteTitle()
                
                Spacer()
            }
        }
        .alert("Game over", isPresented: $isGameCompletedShowing) {
            Button("Try again", action: resetGame)
        } message: {
            Text("Your final score is \(playerScore)")
        }
    }
    
    func checkMove(_ move: Move) {
        switch move {
        case .rock:
            if expectedOutcome == .win && moves[computerMove] == .scissors {
                playerScore += 1
            } else if expectedOutcome == .lose && moves[computerMove] == .paper {
                playerScore += 1
            }
        case .paper:
            if expectedOutcome == .win && moves[computerMove] == .rock {
                playerScore += 1
            } else if expectedOutcome == .lose && moves[computerMove] == .scissors {
                playerScore += 1
            }
        case .scissors:
            if expectedOutcome == .win && moves[computerMove] == .paper {
                playerScore += 1
            } else if expectedOutcome == .lose && moves[computerMove] == .rock {
                playerScore += 1
            }
        }
        nextRound()
    }
    
    func nextRound() {
        if round < 9 {
            computerMove = Int.random(in: 0...2)
            round += 1
            expectedOutcome = round % 2 == 0 ? .win : .lose
        } else {
            isGameCompletedShowing = true
        }
    }
    
    func resetGame() {
        round = 0
        playerScore = 0
        computerMove = Int.random(in: 0...2)
        expectedOutcome = .win
    }
}

#Preview {
    ContentView()
}
