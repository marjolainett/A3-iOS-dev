//
//  TodoView.swift
//  assignment3
//
//  Created by Mathilde Bodet on 03/05/2024.
//

import SwiftUI

struct TodoView: View {
    @Binding var taskLists: [TaskList]
    @State private var newListName = ""
    @State private var selectedListIndex: Int = 0
    @State private var newTaskTitle: String = ""
    @State private var newTaskDate: Date = Date()
    @State private var newTaskTime: Date = Date()
    @State private var sortOrder: SortOrder = .priority
    @State private var selectedPriority: Priority = .low
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack {
            HStack {
                // Picker to select a specific list
                Picker("Select List", selection: $selectedListIndex) {
                    ForEach(0..<taskLists.count, id: \.self) { index in
                        Text(taskLists[index].title)
                            .tag(index)
                    }
                }
                Button(action: {
                    newList()
                }) {
                    Text("+")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            .padding(.top)
            
            // Picker to change the sorting criteria
            HStack {
                Spacer()
                Picker(selection: $sortOrder, label: Text("Order")) {
                    ForEach(SortOrder.allCases, id: \.self) { order in
                        Text(order.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding(.horizontal)
            
            List {
                ForEach(taskLists[selectedListIndex].tasks.sorted(by: sortTasks)) { task in
                    HStack {
                        Text(task.title)
                            .foregroundColor(task.isCompleted ? .gray : task.priority.color)
                        Text(dateFormatter.string(from: task.deadline))
                            .font(.caption)
                            .foregroundColor(task.isCompleted ? .gray : .primary)
                        Text(hourFormatter.string(from: task.hour))
                            .font(.caption)
                            .foregroundColor(task.isCompleted ? .gray : .primary)
                        Spacer()
                        
                        Image(systemName:task.isCompleted ? "checkmark.square" :"square")
                            .onTapGesture {
                                if let index = taskLists[selectedListIndex].tasks.firstIndex(where: { $0.id == task.id }) {
                                    taskLists[selectedListIndex].tasks[index].isCompleted.toggle()
                                }
                            }
                        Image(systemName: "trash")
                            .onTapGesture {
                                if let index = taskLists[selectedListIndex].tasks.firstIndex(where: { $0.id == task.id }) {
                                    taskLists[selectedListIndex].tasks.remove(at: index)
                                }
                            }
                    }
                }
            }
            
            // Add a new task
            VStack {
                HStack {
                    TextField("New Task", text: $newTaskTitle)
                    Button("Add Task") {
                        addTask()
                    }
                }
                HStack {
                    DatePicker("", selection: $newTaskDate, displayedComponents: .date)
                        .frame(maxWidth: .infinity)
                        .labelsHidden()
                    DatePicker("", selection: $newTaskTime, displayedComponents: .hourAndMinute)
                        .frame(maxWidth: .infinity)
                        .labelsHidden()
                    Picker("Priority", selection: $selectedPriority) {
                        ForEach(Priority.allCases, id: \.self) { priority in
                            Text(priority.rawValue)
                                .foregroundColor(priority.color)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("To-Do List")
    }
    
    // Function to sort tasks based on selected sort order
    func sortTasks(_ task1: Task, _ task2: Task) -> Bool {
        switch sortOrder {
        case .priority:
            return task1.priority.rawValue < task2.priority.rawValue
        case .name:
            return task1.title < task2.title
        case .date:
            return task1.deadline < task2.deadline
        }
    }
    
    // Function to add a new task to the selected list
    func addTask() {
        if !newTaskTitle.isEmpty {
            let newTask = Task(title: newTaskTitle, deadline: newTaskDate, hour: newTaskTime, priority: selectedPriority) // Default priority to low
            taskLists[selectedListIndex].tasks.append(newTask)
            newTaskTitle = ""
            newTaskDate = Date()
        }
    }
    
    // Function to add a new list
    func newList(){
        let alert = UIAlertController(title: "New List", message: "Enter the name of the new list", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "To-Do List"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            if let newListName = alert.textFields?.first?.text, !newListName.isEmpty {
                taskLists.append(TaskList(title: newListName))
            }
        }
        alert.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

enum SortOrder: String, CaseIterable {
    case priority = "Priority"
    case name = "Name"
    case date = "Date"
}

#Preview {
    TodoView(taskLists: .constant([
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]))
}
