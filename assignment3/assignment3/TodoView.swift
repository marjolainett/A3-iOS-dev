//
//  TodoView.swift
//  assignment3
//
//  Created by Mathilde Bodet on 03/05/2024.
//

import SwiftUI

struct TodoView: View {
    @Binding var taskLists: [TaskList]
    @State private var selectedListIndex: Int = 0
    @State private var newTaskTitle: String = ""

    var body: some View {
        VStack {
            // Picker to select a specific list
            Picker("Select List", selection: $selectedListIndex) {
                ForEach(0..<taskLists.count, id: \.self) { index in
                    Text(taskLists[index].title).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Task list display
            List {
                ForEach(taskLists[selectedListIndex].tasks) { task in
                    HStack {
                        Text(task.title)
                        Spacer()
                        if task.isCompleted {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                        }
                    }
                }
            }

            // Add a new task
            HStack {
                TextField("New Task", text: $newTaskTitle)
                Button("Add Task") {
                    addTask()
                }
            }
            .padding()
        }
        .navigationTitle("To-Do List")
    }

    // Function to add a new task to the selected list
    func addTask() {
        if !newTaskTitle.isEmpty {
            let newTask = Task(title: newTaskTitle)
            taskLists[selectedListIndex].tasks.append(newTask)
            newTaskTitle = ""
        }
    }
}

#Preview {
    TodoView(taskLists: .constant([
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]))
}

