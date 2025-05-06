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
                
                Text("Fulfilled days:")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(habit.logs.sorted(by: >), id: \.self) { date in
                        Text(date.formatted(date: .abbreviated, time: .omitted))
                            .font(.body)
                    }
                }
                
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
