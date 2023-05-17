//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Artem Mandych on 15.05.2023.
//

import SwiftUI

import FluidGradient

struct ContentView: View {
    @State private var  startOfTheGame = false
    @State private var  countOfQuestions = 0
    @State private var  score = 0
    @State private var  goal1 = -1
    @State private var  goal2 = -1
    @State private var  goal3 = -1
    @State private var  answer = 0
    @State private var  question = ""
    @State private var errorTitle = ""
    @State private var showingAlert = false
    @State private var endOfTheGame = false
    @State private var randomNumber = Int.random(in: 2...12)
    @State private var  range = 2
    let questions = [5,10,20]
    let background = "square_nodetailsOutline"
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    var body: some View {
        NavigationView {
            ZStack {
                createBackground()
                    .overlay(Image(background))
                    .opacity(0.50)
                List {
                    
                        Section {
                            Stepper("Up to \(range)", value: $range, in: 2...12)
                        } header: {
                            HStack {
                                Spacer()
                                Text("Choose multiplication table")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.black)
                                Spacer()
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Rectangle()
                                .fill(.thinMaterial)
                                .frame(width: 365)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    
                    Section {
                        HStack {
                            ForEach(0..<3) { number in
                                Button {
                                    startGame(number)
                                } label: {
                                    HStack {
                                        Spacer()
                                        Text(String(questions[number]))
                                            .frame(width:40)
                                            .padding()
                                            .background()
                                            .clipShape(Circle())
                                        Spacer()
                                    }
                                }
                                .disabled(countOfQuestions >= 1)
                            }
                        }
                    } header: {
                        HStack {
                            Spacer()
                            Text("How many questions do you want?")
                                .font(.headline.weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(width: 365, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                
                        )
                    
                    Section {
                        HStack() {
                            Spacer()
                                Text(question)
                            Spacer()
                            }
                    } header: {
                        HStack {
                            Spacer()
                            Text("Questions left \(startOfTheGame ? countOfQuestions : 0)")
                                .font(.headline.weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(width: 365, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    
                    Section {
                        TextField("Answer",value: $answer, format: .number)
                    } header: {
                        HStack {
                            Spacer()
                            Text("Your answer")
                                .font(.headline.weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    .onSubmit(finalAnswer)
                    .listRowBackground(
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(width: 365, height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    .listRowSeparator(.hidden)
                        
                }
                    .listStyle(.plain)
                    .navigationBarHidden(true)
                    
                }
         
            .alert(errorTitle, isPresented: $showingAlert) {
                Button("Continue", action: askNewQuestion)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("GAME OVER", isPresented: $endOfTheGame) {
                Button("Restart", action: resetGame)
            } message: {
                Text("Your final score is \(score)")
            }
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    
    func startGame(_ number: Int) {
        if questions[number] == 5 {
            goal1 = 5
            countOfQuestions = 5
            randomNumber = Int.random(in: 2...12)
            question = "What is \(Int.random(in:2...range)) x \((randomNumber))?"
        }
        if  questions[number] == 10 {
            randomNumber = Int.random(in: 2...12)
            goal2 = 10
            countOfQuestions = 10
            question = "What is \( Int.random(in:2...range)) x \((randomNumber))?"
        }
        if  questions[number] == 20 {
            goal3 = 20
            countOfQuestions = 20
            randomNumber = Int.random(in: 2...12)
            question = "What is \(Int.random(in:2...range)) x \((randomNumber))?"
        }
startOfTheGame = true
    }
    func finalAnswer() {
        let result = answer
        if result == (range * randomNumber) {
            errorTitle = "Correct"
            showingAlert = true
            score += 1
            goal1 -= 1
            goal2 -= 1
            goal3 -= 1
            countOfQuestions -= 1
        } else if result != (range * randomNumber) {
            errorTitle = "Inсorrect"
            showingAlert = true
            goal1 -= 1
            goal2 -= 1
            goal3 -= 1
            countOfQuestions -= 1
        }
        if goal1 == 0 ||  goal2 == 0 || goal3 == 0 {
            endOfTheGame = true
        }
        answer = 0
    }
    func askNewQuestion() {
        range = Int.random(in: 2...range)
        randomNumber = Int.random(in: 2...12)
        question = "What is \( Int.random(in:2...range)) x \((randomNumber))?"
    }
    func resetGame() {
        question = ""
       goal1 = -1
       goal2 = -1
        goal3 = -1
        score = 0
        countOfQuestions = 0
        startOfTheGame = false
    }
    func createBackground() -> some View {
        FluidGradient(blobs: [.red, .green, .blue],
                                        highlights: [.yellow, .orange, .purple],
                                        speed: 1.0,
                                        blur: 0.75)
        .background(.quaternary)
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }

}


//HStack {
//    Spacer()
//    Button {
//        if range <= 12 || range >= 3 {
//            range -= 1
//        }
//    } label: {
//        Image(systemName: "minus.circle")
//            .font(.system(size: 40))
//
//    }
//    .disabled(goal1 == 4 || goal2 == 9 || goal3 == 19)
//    Text("Up to \(range)")
//
//        Button {
//            if range == 2 {
//                range += 1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//                .font(.system(size: 40))
//        }
//        .disabled(goal1 == 4 || goal2 == 9 || goal3 == 19)
//    Spacer()
//}
