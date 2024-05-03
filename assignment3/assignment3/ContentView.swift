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

                NavigationLink(destination: TodoView(), label: {Text("To-Do List")
                        .font(.title)
                })
                .padding(50)

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
