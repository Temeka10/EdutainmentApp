//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Artem Mandych on 15.05.2023.
//

import SwiftUI

import FluidGradient

struct ContentView: View {
    @State private var titleWidth: CGFloat = 170
    @State private var opacity: Double = 1
    @State private var animationAmount1 = 0.0
    @State private var animationAmount2 = 0.0
    @State private var animationAmount3 = 0.0
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
    @State private var someRange = Int.random(in:2...2)
    @State private var randomNumber = Int.random(in: 2...12)
    @State private var  range = 2
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
                    VStack {
                        
                        Section {
                            Stepper("Up to \(range)", value: $range, in: 2...12)
                                .padding(5)
                                .background(.ultraThickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        } header: {
                            HStack {
                                Spacer()
                                Text("Choose multiplication table")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.black)
                                    .padding()
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Rectangle()
                                .fill(.ultraThickMaterial)
                                .frame(width: 365, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 365, height: 110)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    
                    
                    VStack {
                        Section {
                            
                            HStack(spacing: 30) {
                                Spacer()
                                Button {
                                    
                                } label: {
                                    Text("5")
                                        .font(.headline.weight(.bold))
                                        .frame(width:40)
                                        .padding()
                                        .background()
                                        .clipShape(Circle())
                                }.rotation3DEffect(.degrees(animationAmount1), axis: (x: 0, y: 1, z: 0))
                                    .onTapGesture {
                                        withAnimation(.interpolatingSpring(stiffness: 7, damping: 4)) {
                                            animationAmount1 += 360
                                        }
                                        goal1 = 5
                                        countOfQuestions = 5
                                        someRange = Int.random(in:2...range)
                                        question = "What is \(someRange) x \(randomNumber)?"
                                    }
                                    .disabled(countOfQuestions >= 1)
                                Button {
                                    
                                } label: {
                                    Text("10")
                                        .font(.headline.weight(.bold))
                                        .frame(width:40)
                                        .padding()
                                        .background()
                                        .clipShape(Circle())
                                }
                                .rotation3DEffect(.degrees(animationAmount2), axis: (x: 0, y: 1, z: 0))
                                .onTapGesture {
                                    withAnimation(.interpolatingSpring(stiffness: 7, damping: 4)) {
                                        animationAmount2 += 360
                                    }
                                    goal2 = 10
                                    someRange = Int.random(in:2...range)
                                    countOfQuestions = 10
                                    question = "What is \(someRange) x \(randomNumber)?"
                                }
                                .disabled(countOfQuestions >= 1)
                                Button {
                                    
                                } label: {
                                    Text("20")
                                        .font(.headline.weight(.bold))
                                        .frame(width:40)
                                        .padding()
                                        .background()
                                        .clipShape(Circle())
                                }
                                .rotation3DEffect(.degrees(animationAmount3), axis: (x: 0, y: 1, z: 0))
                                .onTapGesture {
                                    withAnimation(.interpolatingSpring(stiffness: 7, damping: 4)) {
                                        animationAmount3 += 360
                                    }
                                    goal3 = 20
                                    countOfQuestions = 20
                                    someRange = Int.random(in:2...range)
                                    question = "What is \(someRange) x \(randomNumber)?"
                                }
                                .disabled(countOfQuestions >= 1)
                                Spacer()
                                
                            }
                            
                        } header: {
                            HStack {
                                Spacer()
                                Text("How many questions do you want?")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                        
                        .listRowSeparator(.hidden)
                        .listRowBackground(
                            Rectangle()
                                .fill(.ultraThinMaterial)
                                .frame(width: 365, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                        )
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 365, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    VStack {
                        Section {
                            HStack() {
                                Spacer()
                                Text(question)
                                    .opacity(opacity)
                                    .frame(width: titleWidth)
                                    .padding(2)
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .transition(.opacity)
                                    .onChange(of: question) { newValue in
                                        withAnimation(.easeIn(duration: 0)) {
                                            self.opacity = 0
                                        }
                                        withAnimation(.easeIn(duration: 0.5).delay(0.5)) {
                                            self.opacity = 1
                                        }
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            self.titleWidth = 20
                                        }
                                        withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                                            self.titleWidth = 170
                                        }
                                        
                                    }
                                Spacer()
                            }
                        } header: {
                            HStack {
                                Spacer()
                                Text("Questions left \(countOfQuestions)")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.black)
                                    .padding(10)
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 200, height: 76)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                    
                    VStack {
                        Section {
                            HStack(spacing: 95) {
                                Spacer()
                                TextField("Answer",value: $answer, format: .number)
                                    .frame(width: 130)
                                    .padding(5)
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        } header: {
                            HStack {
                                Spacer()
                                Text("Your answer")
                                    .font(.headline.weight(.bold))
                                    .foregroundColor(.black)
                                    .padding(5)
                                    .background(.ultraThickMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                        }
                        .disabled(countOfQuestions < 1)
                        .onSubmit(finalAnswer)
                        .listRowBackground(
                            Rectangle()
                                .fill(.thinMaterial)
                                .frame(width: 200, height: 40)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
                        .listRowSeparator(.hidden)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .frame(width: 200, height: 76)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        )
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
    
    func finalAnswer() {
        let result = answer
        if result == (someRange * randomNumber) {
            errorTitle = "Correct"
            showingAlert = true
            score += 1
            goal1 -= 1
            goal2 -= 1
            goal3 -= 1
            countOfQuestions -= 1
        } else if result != (someRange * randomNumber) {
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
        question = ""
    }
    func askNewQuestion() {
        someRange = Int.random(in: 2...range)
        randomNumber = Int.random(in: 2...12)
        question = "What is \(someRange) x \(randomNumber)?"
    }
    func resetGame() {
        question = ""
       goal1 = -1
       goal2 = -1
        goal3 = -1
        score = 0
        countOfQuestions = 0
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
