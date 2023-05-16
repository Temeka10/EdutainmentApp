//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Artem Mandych on 15.05.2023.
//

import SwiftUI

import FluidGradient

struct ContentView: View {
    @State private var  rightOrNot = false
    @State private var  score = 0
    @State private var  goal = 0
    @State private var  answer = 0
    @State private var  question = ""
    @State private var errorTitle = ""
    @State private var showingAlert = false
    @State private var endOfTheGame = false
    @State private var randomNumber = Int.random(in: 2...12)
    @State private var randomNumber2 = Int.random(in: 2...12)
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
                            HStack {
                                Spacer()
                                Button {
                                    if range <= 12 || range >= 3 {
                                        range -= 1
                                    }
                                } label: {
                                    Image(systemName: "minus.circle")
                                        .font(.system(size: 40))
                                        
                                }
                                .disabled(goal >= 1)
                                Text("Up to \(range)")
                             
                                    Button {
                                        if range == 2 {
                                            range += 1
                                        }
                                    } label: {
                                        Image(systemName: "plus.circle")
                                            .font(.system(size: 40))
                                    }
                                    .disabled(goal >= 1)
                                Spacer()
                            }
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
                                .frame(width: 200)
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
                                .disabled(goal >= 1)
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
                            Text("Question")
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
        if (goal == 5 && questions[number] == 5) || ( goal == 10 && questions[number] == 10 ) || (goal == 20 && questions[number] == 20) {
            endOfTheGame = true
        }
        if questions[number] == 5 {
            goal += 1
            randomNumber = Int.random(in: 2...12)
            question = "What is \(Int.random(in:2...range)) x \((randomNumber))?"
        } else if  questions[number] == 10 {
            goal += 1
            randomNumber = Int.random(in: 2...12)
            question = "What is \(Int.random(in:2...range)) x \((randomNumber))?"
        } else if  questions[number] == 20 {
            goal += 1
            randomNumber = Int.random(in: 2...12)
            question = "What is \(Int.random(in:2...range)) x \((randomNumber))?"
        }
        if answer == (range * randomNumber) {
            showingAlert = true
            errorTitle = "Correct"
            score += 1
        } else if answer != (range * randomNumber) {
            showingAlert = true
            errorTitle = "Incorrect"
        }
    }
    func askNewQuestion() {
        randomNumber = Int.random(in: 2...12)
        question = ""
    }
    func resetGame() {
        randomNumber = Int.random(in: 2...12)
        question = ""
        goal = 0
        score = 0
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


