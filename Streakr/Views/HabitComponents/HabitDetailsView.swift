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
                    Text("🔥 Streak: ")
                    Spacer()
                    Text("\(habit.streak) Days!")
                }
                
                HStack {
                    Text("📅 Created: ")
                    Spacer()
                    Text(habit.createdAt.formatted(date: .abbreviated, time: .omitted))
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
}

//#Preview {
//    HabitDetailsView()
//}
