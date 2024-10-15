import SwiftUI

extension Date {
    func format(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = .init()
        var date: Date
    }
    
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    func fetchWeek(_ date: Date = .init()) -> [WeekDay] {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date)
    
        var week: [WeekDay] = []
        let weekDate = calendar.dateInterval(of: .weekOfMonth, for: startDate)
        guard let startWeek = weekDate?.start else {
            return []
        }
        
        (0..<7).forEach { index in
            if let weekDate = calendar.date(byAdding: .day, value: index, to: startWeek) {  // Alterado 'startDate' para 'startWeek'
                week.append(.init(date: weekDate))  // Corrigido para 'weekDate'
            }
        }
        
        return week
    }
}
 
