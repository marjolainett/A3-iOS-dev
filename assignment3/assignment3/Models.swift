//
//  Models.swift
//  assignment3
//
//  Created by Loki on 7/5/2024.
//

import Foundation
import SwiftUI

enum Priority: String, CaseIterable {
    case low = "!"
    case medium = "!!"
    case high = "!!!"
    
    var color: Color {
        switch self {
        case .low:
            return .green
        case .medium:
            return .yellow
        case .high:
            return .red
        }
    }
}

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    var deadline: Date
    var hour: Date
    var priority: Priority // Add priority property
}

struct TaskList: Identifiable {
    let id = UUID()
    var title: String
    var tasks: [Task] = []
}
