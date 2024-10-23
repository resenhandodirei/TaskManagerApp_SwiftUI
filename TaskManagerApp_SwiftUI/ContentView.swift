//
//  ContentView.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import SwiftUI

// Modelo de tarefa
struct Task: Identifiable {
    var id = UUID() // Identificador único para cada tarefa
    var name: String
    var date: Date
}

struct ContentView: View {
    @State var currentDate: Date = Date()
    @State var weekSlider: [Date] = [] // Aqui serão armazenadas múltiplas semanas
    @State var currentWeekIndex: Int = 0
    @State var selectedDate: Date = Date() // Estado para o dia selecionado
    
    // Lista de tarefas de exemplo
    @State var tasks: [Task] = [
        Task(name: "Complete SwiftUI tutorial", date: Date()),
        Task(name: "Meet with team", date: Date()),
        Task(name: "Submit report", date: Date())
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Calendar")
                .font(.system(size: 36, weight: .semibold))
                .padding(.horizontal)
                .padding(.bottom, 20)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let weekStartDate = weekSlider[index]
                    
                    // Para cada semana, obtenha os dias e exiba
                    weekView(fetchWeek(for: weekStartDate))
                        .tag(index) // Importante para rastrear o índice atual
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.1))
        
            Rectangle()
                .fill(Color.gray.opacity(0.1))
                .clipShape(RoundedCorner(radius: 30, corners: [.bottomLeft, .bottomRight]))
                .frame(height: 30)
                .ignoresSafeArea(.all, edges: .bottom)
        }
        .onAppear(perform: setupWeekSlider)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func weekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack {
                    Text(day.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.format("dd"))
                        .font(.system(size: 20))
                        .frame(width: 40, height: 40)
                        .background(content: {
                            if isSameDate(day.date, selectedDate) {
                                RoundedRectangle(cornerRadius: 15).fill(.blue) // Destaque o dia selecionado
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        })
                        .onTapGesture {
                            selectedDate = day.date // Atualiza o dia selecionado ao tocar
                        }
                    
                    Spacer()
                    
                    // Exibe a lista de tarefas
                    ScrollView(.vertical) {
                        VStack {
                            TaskView() // Exibe a lista de tarefas
                        }
                        .hSpacing(.center)
                        .vSpacing(.center)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    @ViewBuilder
    func TaskView() -> some View {
        VStack(alignment: .leading) {
            ForEach(tasks) { task in
                TaskItemView(task: task) // Passa cada tarefa para a view
            }
        }
    }
    
    // Este método será chamado ao carregar a tela para configurar várias semanas
    func setupWeekSlider() {
        let calendar = Calendar.current
        let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: currentDate)
        
        // Adiciona semanas antes e depois da semana atual
        for i in -4...4 { // Aqui define quantas semanas deseja carregar
            if let startOfWeek = calendar.date(byAdding: .weekOfMonth, value: i, to: currentWeek!.start) {
                weekSlider.append(startOfWeek)
            }
        }
    }
    
    // Função para obter os dias da semana a partir da data
    func fetchWeek(for date: Date) -> [Date.WeekDay] {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
        var week: [Date.WeekDay] = []
        let weekDate = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard let startWeek = weekDate?.start else {
            return []
        }
        
        (0..<7).forEach { index in
            if let weekDate = calendar.date(byAdding: .day, value: index, to: startWeek) {
                week.append(.init(date: weekDate))
            }
        }
        
        return week
    }
    
    func isSameDate(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
}

// View para exibir cada item de tarefa
struct TaskItemView: View {
    var task: Task
    
    var body: some View {
        HStack {
            Text(task.name)
                .font(.body)
                .padding()
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
        .padding(.horizontal)
    }
}

// Para arredondar cantos específicos
struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
