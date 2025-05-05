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
            
            Spacer()
            
            Text("🔥Streak: \(habit.streak)")
                .font(.subheadline)
            
            
            Text("Started: \(habit.createdAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundStyle(.gray)
            
            
            Button(action: logAction) {
                Text(hasLoggedToday ? "Done for today!" : "Finished?")
                    .font(.caption)
                    .padding(6)
                    .frame(maxWidth: .infinity)
                    .background(hasLoggedToday ? Color.green.opacity(0.6) : Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            .disabled(hasLoggedToday)
        }
        .padding()
        .background(Color(.systemGray6))
        .clipShape(.rect(cornerRadius: 12))
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
