//
//  CalendarView.swift
//  assignment3
//
//  Created by Mathilde Bodet on 08/05/2024.
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedListIndex: Int = 0
    @State var selectedDate: Date = Date()
    @Binding var taskLists: [TaskList]
    
    let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    var body: some View {
        VStack {
            
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding(.horizontal)
            
            Text("To Do on: \(selectedDate, formatter: dateFormatter)")
            List {
                ForEach($taskLists) { $taskList in
                    ForEach($taskList.tasks) { $task in
                        if Calendar.current.isDate($task.deadline.wrappedValue, inSameDayAs: selectedDate) {
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
                }
            }
        }
        .navigationTitle("Calendar")
    }
}

            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                return formatter
            }()


#Preview {
    CalendarView(taskLists: .constant([
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]))
}
