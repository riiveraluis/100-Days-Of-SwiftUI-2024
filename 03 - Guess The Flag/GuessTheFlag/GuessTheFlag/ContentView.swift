//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Luis Rivera Rivera on 2/8/24.
//

import SwiftUI

// Challenge 4
/* Replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.*/
struct FlagImage: View {
    var imageName: String
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    // Challenge 1
    /* Add an @State property to store the user’s score, modify it when they get an answer right or wrong, then display it in the alert and in the score label. */
    @State private var userScore = 0
    // Challenge 3
    /* Make the game show only 8 questions, at which point they see a final alert judging their score and can restart the game.*/
    @State private var round = 1
    @State private var isGameOverShowing = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline).fontWeight(.heavy)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle).fontWeight(.semibold)
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            scoreTitle == "Correct" ? Text("Your score is \(userScore)") : Text("\(scoreMessage)\nYour score is \(userScore)")
        }
        .alert("Game Completed", isPresented: $isGameOverShowing) {
            Button("Try again", action: resetGame)
        } message: {
            Text("Your final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong"
            // Challenge 2
            /* When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.*/
            scoreMessage =  "That’s the flag of \(countries[number])"
            userScore -= 1
        }
        
        if round < 8 {
            showingScore = true
        } else {
            isGameOverShowing = true
        }
    }
    
    func askQuestion() {
        round += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        userScore = 0
        round = 1
        askQuestion()
    }
}

#Preview {
    ContentView()
}
