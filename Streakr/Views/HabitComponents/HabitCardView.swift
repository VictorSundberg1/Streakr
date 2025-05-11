//
//  HabitCardView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-05.
//

import SwiftUI

struct HabitCardView: View {
    let habit: Habit
    let logAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(habit.title)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            Text("🔥Streak: \(habit.streak)")
                .font(.subheadline)
                .foregroundStyle(.primary)
            
            
            Text("Started: \(habit.createdAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            
            Button(action: logAction) {
                Text(hasLoggedToday ? "Done for today!🎊" : "Mark as done!")
                    .font(.caption)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(hasLoggedToday ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
                    .foregroundStyle(.primary)
                    .clipShape(Capsule())
            }
            .disabled(hasLoggedToday)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 2)
    }
    
    private var hasLoggedToday: Bool {
        habit.logs.contains {
            Calendar.current.isDate($0, inSameDayAs: Date())
        }
    }
}

//#Preview {
//    HabitCardView()
//}
