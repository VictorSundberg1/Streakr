//
//  HabitDetailsView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-06.
//

import SwiftUI

struct HabitDetailsView: View {
    let habit: Habit
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                Text(habit.title)
                    .font(.largeTitle.bold())
                
                HStack {
                    Text("📅 Created: ")
                    Spacer()
                    Text(habit.createdAt.formatted(date: .abbreviated, time: .omitted))
                }
                
                HStack {
                    Text("🔥 Streak: ")
                    Spacer()
                    Text("\(habit.streak) Days!")
                }
                
                if let goal = habit.goal, goal > 0 {
                    HStack {
                        ProgressView(value: Double(habit.streak), total: Double(goal))
                            .tint(.green)
                        
                        Text("\(progressPercent(for: habit))%")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    
                    Text("\(habit.streak)/\(goal) days!")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            
                if let description = habit.description, !description.isEmpty {
                    Divider()
                    VStack {
                        Text("📝 Description")
                            .font(.headline)
                        
                        Text(description)
                            .font(.body)
                        
                    }
                }
            
                Divider()
                Spacer()
                
                HabitCalendarView(habit: habit)
                
                Spacer()
                
            }
            .padding()
        }
        .navigationTitle("Habit")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func progressPercent(for habit: Habit) -> Int {
        guard let goal = habit.goal, goal > 0 else { return 0 }
        let progress = Double(habit.streak) / Double(goal)
        return Int((progress * 100).rounded())
    }
    
}

//#Preview {
//    HabitDetailsView()
//}
