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
            Button(action: {
                        
                        newList()
                    }) {
                        Text("Add a new To-Do List!")
                    }
            // Picker to select a specific list
            Picker("Select List", selection: $selectedListIndex) {
                ForEach(0..<taskLists.count, id: \.self) { index in
                    Text(taskLists[index].title)
                        .tag(index)
    
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Task list display
            List ($taskLists[selectedListIndex].tasks.sorted(by: {
                if $0.wrappedValue.isCompleted != $1.wrappedValue.isCompleted {
                    return !$0.wrappedValue.isCompleted && $1.wrappedValue.isCompleted
                } else {
                    if $0.wrappedValue.deadline != $1.wrappedValue.deadline {
                        return $0.wrappedValue.deadline < $1.wrappedValue.deadline
                    } else {
                        return $0.wrappedValue.hour < $1.wrappedValue.hour
                    }
                }
            })){
                $task in
                HStack {
                    Text(task.title)
                    Text(dateFormatter.string(from: task.deadline))
                        .font(.caption)
                    Text(hourFormatter.string(from: task.hour))
                        .font(.caption)
                    Spacer()
                    
                    Image(systemName:task.isCompleted ? "checkmark.square" :"square")
                        .onTapGesture(perform: {
                            task.isCompleted.toggle()
                            
                        })
                    Image(systemName: "trash")
                        .onTapGesture {
                            if let index = taskLists[selectedListIndex].tasks.firstIndex(where: { $0.id == task.id }) {
                                taskLists[selectedListIndex].tasks.remove(at: index)
                            }
                            
                            
                        }
                }
            }

            // Add a new task
            HStack {
                TextField("New Task", text: $newTaskTitle)
                Spacer()
                DatePicker("", selection: $newTaskDate, displayedComponents: .date)
                DatePicker("", selection: $newTaskTime, displayedComponents: .hourAndMinute)
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
            let newTask = Task(title: newTaskTitle, deadline: newTaskDate, hour: newTaskTime)
            taskLists[selectedListIndex].tasks.append(newTask)
            newTaskTitle = ""
            newTaskDate = Date()
        }
    }
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


#Preview {
    TodoView(taskLists: .constant([
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]))
}

