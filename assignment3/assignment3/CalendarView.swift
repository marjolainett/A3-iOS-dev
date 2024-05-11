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
                        .padding()
            
            Text("To Do on: \(selectedDate, formatter: dateFormatter)")
                .padding()
            ForEach($taskLists) { $taskList in
                ForEach($taskList.tasks) { $task in
                    if Calendar.current.isDate($task.deadline.wrappedValue, inSameDayAs: selectedDate) {
                        HStack {
                            Text($task.title.wrappedValue)
                            Text(dateFormatter.string(from: $task.deadline.wrappedValue))
                                .font(.caption)
                            Text(hourFormatter.string(from: $task.hour.wrappedValue))
                                .font(.caption)
                            Spacer()
                            
                            Image(systemName: $task.isCompleted.wrappedValue ? "checkmark.square" : "square")
                                .onTapGesture {
                                    $task.isCompleted.wrappedValue.toggle()
                                }
                            Image(systemName: "trash")
                                .onTapGesture {
                                    if let index = $taskLists.wrappedValue[selectedListIndex].tasks.firstIndex(where: { $0.id == $task.id }) {
                                        $taskLists.wrappedValue[selectedListIndex].tasks.remove(at: index)
                                    }
                                }
                        }
                    }
                }
            }
            Spacer()
                }
            }

            let dateFormatter: DateFormatter = {
                let formatter = DateFormatter()
                formatter.dateStyle = .long
                formatter.timeStyle = .none
                return formatter
            }()
        }

#Preview {
    CalendarView(taskLists: .constant([
        TaskList(title: "Work"),
        TaskList(title: "Personal")
    ]))
}
