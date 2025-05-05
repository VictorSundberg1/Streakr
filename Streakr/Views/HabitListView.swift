//
//  HabitListView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import SwiftUI

struct HabitListView: View {
    @EnvironmentObject var habitVM: HabitViewModel
    @State private var newHabitTitle = ""
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    TextField("New Habit", text: $newHabitTitle)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    
                    Button("Add habit") {
                        Task {
                            guard !newHabitTitle.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            await habitVM.addHabit(title: newHabitTitle)
                            newHabitTitle = ""
                        }
                    }
                }
                .padding()
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(habitVM.habits) { habit in
                            HabitCardView(habit: habit) {
                                Task {
                                    await habitVM.logToday(for: habit)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("My Habits")
                .task {
                    await habitVM.fetchHabits()
                }
            }
        }
    }
    
}

//#Preview {
//    HabitListView()
//}

struct HabitListView_Previews: PreviewProvider {
    static var previews: some View {
        HabitListView()
            .environmentObject(HabitViewModel())
    }
}
