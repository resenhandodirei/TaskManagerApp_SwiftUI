//
//  TaskView.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 22/10/24.
//

import SwiftUI

struct TaskItem: View {
    
    @Binding var task: UserTask // Agora o tipo é 'UserTask' para evitar o conflito
    
    var body: some View {
        Text(task.name) // Exibindo o nome da tarefa
    }
}

#Preview {
    ContentView()
}

