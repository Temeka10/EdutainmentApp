//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Artem Mandych on 15.05.2023.
//

import SwiftUI

import FluidGradient

struct ContentView: View {
    var body: some View {
          FluidGradient(blobs: [.red, .green, .blue],
                        highlights: [.yellow, .orange, .purple],
                        speed: 1.0,
                        blur: 0.75)
            .background(.quaternary)
            .ignoresSafeArea()
      }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
