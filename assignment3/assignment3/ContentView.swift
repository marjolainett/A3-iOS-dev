//
//  ContentView.swift
//  assignment3
//
//  Created by Mathilde Bodet on 03/05/2024.
//

import SwiftUI

//ContentView is the view of the home page

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack {
                Label("Organizer App", systemImage: "")
                    .foregroundColor(.mint)
                    .font(.largeTitle)
                Spacer()
//You can click New Game to play the game
                NavigationLink(destination: TodoView(), label: {Text("To-Do List")
                        .font(.title)
                })
                .padding(50)
//You can click High Score to access the 10 best results with the name of the player
                NavigationLink(destination: ReminderView(), label: {Text("Add a reminder")
                        .font(.title)
                })
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
