//
//  CalendarExtension.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-06.
//

import Foundation

extension Date {
    
    //Gets the first day of the month from the month input
    func startOfMonth(using calendar: Calendar = .current) -> Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
    }
    
    //takes in one day of the month and returns list of all the days in the given month
    func daysInMonth(using calendar: Calendar = .current) -> [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: self) else { return [] }
        let start = self.startOfMonth(using: calendar)
        return range.compactMap { calendar.date(byAdding: .day, value: $0 - 1, to: start) }
    }
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
}
