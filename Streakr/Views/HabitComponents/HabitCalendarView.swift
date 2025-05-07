//
//  HabitCalendarView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-06.
//

import SwiftUI

struct HabitCalendarView: View {
    let habit: Habit
    private let calendar = Calendar.current
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(currentMonthString().capitalized) 📅")
                .font(.headline)
                .padding(.bottom, 5)
            Text("How are you doing this month? 🫣")
                .font(.subheadline)
                .padding(.bottom, 15)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(weekdays, id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .foregroundStyle(.gray)
                }
                
                //placeholders for before month has started
                ForEach(0..<leadingEmptyDays, id: \.self) { _ in
                    Color.clear
                        .frame(width: 32, height: 32)
                }
                
                //shows Days in this month
                ForEach(currentMonthDates, id: \.self) { date in
                    let isLogged = habit.logs.contains {
                        calendar.isDate($0, inSameDayAs: date)
                    }
                    let shouldShowAsMissed = isPast(date) && !isLogged && date >= calendar.startOfDay(for: habit.createdAt)
                    
                    Circle()
                        .fill(circleColor(for: date, isLogged: isLogged, isMissed: shouldShowAsMissed))
                        .frame(width: 32, height: 32)
                        .overlay(
                            Text("\(calendar.component(.day, from: date))")
                                .font(.caption)
                                .foregroundStyle(.white)
                        )
                }
            }
        }
    }
    
    //Count for how many weekdays should be skipped before month starts
    private var leadingEmptyDays: Int {
        let firstDay = currentMonthDates.first!
        let weekday = calendar.component(.weekday, from: firstDay)
        let adjusted = weekday - calendar.firstWeekday
        return adjusted >= 0 ? adjusted : adjusted + 7
    }
    
    //Get a string of the current month and year of the users settings language
    private func currentMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: Date())
    }
    
    //amount of days in current month
    private var currentMonthDates: [Date] {
        Date().startOfMonth().daysInMonth()
    }
    
    //name of weekdays
    private var weekdays: [String] {
        let symbols = calendar.shortWeekdaySymbols
        let firstWeekdayIndex = calendar.firstWeekday - 1
        return Array(symbols[firstWeekdayIndex...] + symbols[..<firstWeekdayIndex])
    }
    
    //check to see if date is before today or not
    private func isPast(_ date: Date) -> Bool {
        calendar.startOfDay(for: date) < calendar.startOfDay(for: Date())
    }
    
    //Returns the color of each day in the calender
    private func circleColor(for date: Date, isLogged: Bool, isMissed: Bool) -> Color {
        if date.isToday { return .blue }
        if isLogged { return .green}
        if isMissed { return .red.opacity(0.4)}
        return .gray.opacity(0.3)
    }
 
    
    
}



//#Preview {
//    HabitCalendarView()
//}
