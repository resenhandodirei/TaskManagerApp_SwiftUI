//
//  Task.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import SwiftUI

struct Task: Identifiable {
    var id: UUID = .init()
    var title: String
    var caption: String
    var date: Date = .init()
    var isCompleted = false
    var tint: Color
}

// Simple task
var sampleTask: [Task] = [
    .init(title: "Standup", caption: "Every day meeting", date: Date.now, tint: .yellow),
    .init(title: "Kickoff", caption: "Travel App", date: Date.now, tint: .gray),
    .init(title: "UI Design", caption: "Fintech App", date: Date.now, tint: .green),
    .init(title: "Logo Design", caption: "Fintech App", date: Date.now, tint: .purple)
]




extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}
