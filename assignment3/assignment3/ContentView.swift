//
//  ContentView.swift
//  assignment3
//
//  Created by Mathilde Bodet on 03/05/2024.
//

import SwiftUI

struct ContentView: View {
    // Sample lists for initial display
    @State private var taskLists = [
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]

    var body: some View {
        NavigationView {
            VStack {
                Label("Organizer App", systemImage: "checkmark.seal")
                    .foregroundColor(.mint)
                    .font(.largeTitle)
                Spacer()

                NavigationLink(destination: TodoView(taskLists: $taskLists)) {
                    Text("To-Do List")
                        .font(.title)
                }
                .padding(50)

                NavigationLink(destination: ReminderView()) {
                    Text("Add a Reminder")
                        .font(.title)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
