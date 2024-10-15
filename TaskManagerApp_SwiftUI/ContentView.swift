//
//  ContentView.swift
//  TaskManagerApp_SwiftUI
//
//  Created by Larissa Martins Correa on 14/10/24.
//

import SwiftUI

struct ContentView: View {
    @State var currentDate: Date = Date()
    @State var weekSlider: [Date] = []
    @State var currentWeekIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Calendar")
                .font(.system(size: 36, weight: .semibold))
                .padding(.horizontal)
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let weekDate = weekSlider[index]
                    
                    weekView(fetchWeek(for: weekDate))
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
    
    // Mover a função `weekView` para fora da view principal
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
                            if isSameDate(day.date, currentDate) {
                                RoundedRectangle(cornerRadius: 15).fill(.blue)
                            }
                            
                            if day.date.isToday {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                            }
                        })
                }
            }
        }
    }
    
    func setupWeekSlider() {
        // Gera os dias da semana a partir da data atual
        let calendar = Calendar.current
        let currentWeek = calendar.dateInterval(of: .weekOfMonth, for: currentDate)
        if let startOfWeek = currentWeek?.start {
            weekSlider = (0..<7).compactMap { dayOffset in
                calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
            }
        }
    }
    
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
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: date)
    }
}

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
