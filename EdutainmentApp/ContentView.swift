//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Artem Mandych on 15.05.2023.
//

import SwiftUI

import FluidGradient

struct ContentView: View {
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
                    .listRowBackground(
                        Rectangle()
                            .fill(.thinMaterial)
                            .frame(width: 365)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    )
                    .listRowSeparator(.hidden)
                   
                 
                }
                .listStyle(.plain)
                .navigationBarHidden(true)
                        
            }
            .navigationBarTitleDisplayMode(.inline)
        }
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

//    Image(background)
