//
//  ContentView.swift
//  Edutainment
//
//  Created by Luis Rivera Rivera on 2/23/24.
//

import SwiftUI

enum Table: Int, CaseIterable {
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
}

struct Question {
    let operand1: Int
    let operand2: Int
    
    var answer: Int {operand1 * operand2}
    
    static var example = Question(operand1: 5, operand2: 6)
}

struct QuestionView: View {
    let question: Question
    let answer: String
    
    var body: some View {
        HStack {
            Text(question.operand1.description)
                .foregroundStyle(.blue.gradient)
            
            Text("x")
            
            Text(question.operand2.description)
                .foregroundStyle(.red.gradient)
            Text("=")
            
            Text(answer.isEmpty ? "__" : answer)
        }
        .font(.largeTitle)
        .fontDesign(.rounded)
    }
}

struct KeypadButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .padding()
            .background(.regularMaterial)
            .foregroundStyle(.black)
            .clipShape(Circle())
            .frame(width: 75)
    }
}

extension View {
    func keypadButtonStyle() -> some View {
        modifier(KeypadButtonStyleModifier())
    }
}

struct ContentView: View {
    // Setup Screen variables
    @State private var table: Table = .two
    let numberOfQuestionsOptions = [5, 10, 20]
    @State private var numberOfQuestions = 5
    
    // Game Screen Variables
    @State private var isGameActive = false
    @State private var questions = [Question]()
    @State private var questionsAsked = 0
    @State private var answer = ""
    @State private var userScore = 0
    @State private var isShowingGameEndedAlert = false
    
    var body: some View {
        NavigationStack {
            if !isGameActive {
                Form {
                    Section("Select multiplication table to practice") {
                        Picker("Table of", selection: $table) {
                            ForEach(Table.allCases, id: \.self) {
                                Text($0.rawValue.description)
                            }
                        }
                        .pickerStyle(.automatic)
                    }
                    
                    Section("Number of questions") {
                        Picker("Number of questions", selection: $numberOfQuestions) {
                            ForEach(numberOfQuestionsOptions, id: \.self) {
                                Text($0.description)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section("Question example") {
                        QuestionView(question: Question(operand1: table.rawValue, operand2: Int.random(in: 2...12)), answer: "")
                    }
                    
                    HStack {
                        Spacer()
                        Button("Begin Practice", action: beginGame)
                        Spacer()
                    }
                }
                .navigationTitle("Edutainment Setup")
            } else {
                ZStack {
                    LinearGradient(colors: [
                        .orange,
                        .yellow,
                        .orange
                    ],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                    
                    VStack {
                        Text("Practicing table of \(table.rawValue.description)")
                            .font(.largeTitle)
                        
                        HStack {
                            Text("Question")
                            Text("\(questionsAsked + 1)")
                                .bold()
                            Text("of")
                            Text(numberOfQuestions.description)
                        }
                        .font(.title)
                        .padding(.top)
                        
                        QuestionView(question: questions[questionsAsked], answer: answer)
                            .padding(.top, 50)
                        
                        VStack(spacing: 15) {
                            HStack(spacing: 30) {
                                Button("1"){ addToTextField("1")}
                                    .keypadButtonStyle()
                                Button("2"){ addToTextField("2")}
                                    .keypadButtonStyle()
                                Button("3"){ addToTextField("3")}
                                    .keypadButtonStyle()
                            }
                            HStack(spacing: 30) {
                                Button("4"){ addToTextField("4")}
                                    .keypadButtonStyle()
                                Button("5"){ addToTextField("5")}
                                    .keypadButtonStyle()
                                Button("6"){ addToTextField("6")}
                                    .keypadButtonStyle()
                            }
                            HStack(spacing: 30) {
                                Button("7"){ addToTextField("7")}
                                    .keypadButtonStyle()
                                Button("8"){ addToTextField("8")}
                                    .keypadButtonStyle()
                                Button("9"){ addToTextField("9")}
                                    .keypadButtonStyle()
                            }
                            HStack(spacing: 30) {
                                Button(""){}.keypadButtonStyle().opacity(0)
                                Button("0"){ addToTextField("0")}
                                    .keypadButtonStyle()
                                Button {
                                    deleteNumber()
                                } label: {
                                    Image(systemName: "delete.backward")
                                        .font(.title3.bold())
                                }
                                .keypadButtonStyle()
                            }
                        }
                        .padding(.top)
                        
                        Button(action: submitAnswer) {
                            Text("Submit")
                                .foregroundStyle(.black)
                                .bold()
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .padding(.top)
                        }
                        
                        Button {
                            isShowingGameEndedAlert = true
                        } label: {
                            Text("End Practice")
                                .foregroundStyle(.black)
                                .bold()
                                .padding()
                                .background(.regularMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .padding(.top)
                        }
                    }
                }
                .alert("Practice completed", isPresented: $isShowingGameEndedAlert) {
                    Button("Try Again", action: beginGame)
                    Button("Practice other table") {
                        withAnimation {
                            isGameActive = false
                        }
                    }
                } message: {
                    Text("You got \(userScore) of \(numberOfQuestions) right.")
                }
            }
        }
    }
    
    func beginGame() {
        generateQuestions()
        userScore = 0
        answer.removeAll()
        questionsAsked = 0
        withAnimation {
            isGameActive = true
        }
    }
    
    func generateQuestions() {
        questions.removeAll()
        for _ in 0..<numberOfQuestions {
            questions.append(Question(operand1: table.rawValue, operand2: Int.random(in: 2...12)))
        }
        print(questions)
    }
    
    func addToTextField(_ text: String) {
        if answer.count < 3 {
            answer += text
        }
    }
    
    func deleteNumber() {
        if !answer.isEmpty {
            answer.removeLast()
        }
    }
    
    func submitAnswer() {
        guard let answerConverted = Int(answer) else { return }
        
        if answerConverted == questions[questionsAsked].answer {
            userScore += 1
        }
        
        if questionsAsked < numberOfQuestions - 1 {
            questionsAsked += 1
            answer.removeAll()
        } else {
            isShowingGameEndedAlert = true
        }
    }
}

#Preview {
    ContentView()
}
