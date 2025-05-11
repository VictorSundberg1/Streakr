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
    @State private var showAddHabitSheet = false
    
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("My Habits")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.primary)
                
                Spacer()
                
                Button("Add habit") {
                    showAddHabitSheet = true
                }
                .sheet(isPresented: $showAddHabitSheet) {
                    AddHabitView()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .background(Color(.systemGroupedBackground))
                            
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
            .background(Color(.systemGroupedBackground))
        }
        .task {
            await habitVM.fetchHabits()
        }
        .sheet(item: $selectedHabit) { habit in
            HabitDetailsView(habit: habit)
        }
        .background(Color(.systemGroupedBackground))
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
