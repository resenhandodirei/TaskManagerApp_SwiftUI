//
//  Task.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import Foundation

// Modelo de tarefa, renomeado para evitar conflitos
struct UserTask: Identifiable {
    var id = UUID()
    var name: String
    var date: Date
}

// Extensão para atualizar a hora de um Date
extension Date {
    static func updateHour(_ value: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .hour, value: value, to: .init()) ?? .init()
    }
}

