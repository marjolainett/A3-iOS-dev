//
//  Models.swift
//  assignment3
//
//  Created by Loki on 7/5/2024.
//

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var deadline: Date
    var hour: Date
}

struct TaskList: Identifiable {
    let id = UUID()
    var title: String
    var tasks: [Task] = []
}
