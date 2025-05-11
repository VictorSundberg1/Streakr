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
    
    
    //Counts how many days in a row habit has been logged
    var streak: Int {
        //sorts logs from newest to oldest
        let sortedDates = logs.sorted(by: { $0 > $1 })
        guard !sortedDates.isEmpty else { return 0 }
        
        var currentStreak = 0
        
        //gets timezone to handle the date
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        
        //gets the current day to compare with
        var expectedDate = calendar.startOfDay(for: Date())
        
        //goes through all logs and compares the dates to expected date and if it is then the streak gets a plus and expected date jumps 1 day back to compare again
        for date in sortedDates {
            let logDate = calendar.startOfDay(for: date)
            if logDate == expectedDate || calendar.isDate(logDate, inSameDayAs: expectedDate) {
                currentStreak += 1
                expectedDate = calendar.date(byAdding: .day, value: -1, to: expectedDate)!
            }
            //if there is a date missing then break loop
            else if logDate < expectedDate {
                break
            }
        }
        return currentStreak
    }
}
