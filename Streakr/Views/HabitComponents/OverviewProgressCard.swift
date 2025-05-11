//
//  OverviewProgressCard.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-07.
//

import SwiftUI

struct OverviewProgressCard: View {
    let habit: Habit
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                Text(habit.title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
            //checks that goal is bigger than nil and then shows a progressview how far along you are and shows a percent
            if let goal = habit.goal, goal > 0 {
                ProgressView(value: Double(habit.streak), total: Double(goal))
                    .tint(.green)
                
                Text("\(habit.streak)/\(goal) days! \(progressPercent())%")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                Text("No goal assigned!")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            HStack {
                Text("Logged today: ")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(hasLoggedToday ? "✅" : "❌")
                    .font(.caption)
            }
        }
        .padding()
        .frame(width: 200)
        .background(Color(.secondarySystemBackground))
        .clipShape(.rect(cornerRadius: 12))
        .shadow(radius: 2)
    }
    
    //Checks if habit is logged today
    private var hasLoggedToday: Bool {
        habit.logs.contains {
            Calendar.current.isDate($0, inSameDayAs: Date())
        }
    }
    
    //Function to calculate and return the percent from streak / goal
    private func progressPercent() -> Int {
        guard let goal = habit.goal, goal > 0 else { return 0 }
        let progress = Double(habit.streak) / Double(goal)
        return Int((progress * 100).rounded())
    }
}

//#Preview {
//    OverviewProgressCard()
//}
