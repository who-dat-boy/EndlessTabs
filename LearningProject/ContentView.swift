//
//  ContentView.swift
//  LearningProject
//
//  Created by Arthur ? on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .navigationTitle("Endless tabs")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
