//
//  Habit.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import Foundation
import FirebaseFirestore

struct Habit: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var description: String?
    var goal: Int?
    var createdAt: Date
    var logs: [Date]
    
    var streak: Int {
        let sortedDates = logs.sorted(by: { $0 > $1 })
        guard !sortedDates.isEmpty else { return 0 }
        
        var currentStreak = 0
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var expectedDate = calendar.startOfDay(for: Date())
        
        for date in sortedDates {
            let logDate = calendar.startOfDay(for: date)
            if logDate == expectedDate || calendar.isDate(logDate, inSameDayAs: expectedDate) {
                currentStreak += 1
                expectedDate = calendar.date(byAdding: .day, value: -1, to: expectedDate)!
            } else if logDate < expectedDate {
                break
            }
        }
        return currentStreak
    }
}
