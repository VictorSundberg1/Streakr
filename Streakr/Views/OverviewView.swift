//
//  OverviewView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import SwiftUI

struct OverviewView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Overview")
                    .font(.largeTitle.bold())
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("🔥 Total streaks of all habits")
                        .font(.headline)
                    Text("\(habitVM.allStreaksTotal()) days!")
                        .font(.subheadline)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 12))
                .shadow(radius: 1)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("✅ Logged habits today")
                        .font(.headline)
                    Text("\(habitVM.loggedToday()) out of \(habitVM.habits.count) active!")
                        .font(.subheadline)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(.rect(cornerRadius: 12))
                .shadow(radius: 1)
                
                Divider()
                
                //horizontal scrollview for the cards of the habits
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(habitVM.habits) { habit in
                            OverviewProgressCard(habit: habit)
                        }
                    }
                }
                
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    OverviewView()
}
