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
    @State private var selectedHabit: Habit?
    
    
    var body: some View {
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
            
            List {
                Section {
                    ForEach(habitVM.habits) { habit in
                        HabitCardView(habit: habit) {
                            Task {
                                await habitVM.logToday(for: habit)
                            }
                        }
                        .onTapGesture {
                            selectedHabit = habit
                        }
                        .listRowSeparator(.hidden)
                        .contentShape(Rectangle())
                    }
                    .onDelete { indexSet in
                        Task {
                            await habitVM.deleteHabit(at: indexSet)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .listStyle(.plain)
            .background(Color(.systemBackground))
        }
        .navigationTitle("My Habits")
        .task {
            await habitVM.fetchHabits()
        }
        .sheet(item: $selectedHabit) { habit in
            HabitDetailsView(habit: habit)
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
