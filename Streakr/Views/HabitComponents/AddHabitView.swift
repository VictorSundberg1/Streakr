//
//  AddHabitView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-07.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var habitVM: HabitViewModel
    
    @State private var title = ""
    @State private var description = ""
    @State private var goal: Double = 30
    @State private var enableGoal = false
    
    var body: some View {
        NavigationView {
            Form {
                Section("Title") {
                    TextField("Enter habit title", text: $title)
                        .autocorrectionDisabled()
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                        .autocorrectionDisabled()
                }
                //Toggle to make sure you can create a habit without a goal
                Section("Goal (days)") {
                    Toggle("Set goal?", isOn: $enableGoal)
                    
                    if enableGoal {
                        VStack(alignment: .leading) {
                            Slider(value: $goal, in: 5...100, step: 1)
                            Text("Goal: \(Int(goal)) days")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Add new habit tracker!")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            //only sends goal if the goal toggle is on otherwise sends nil
                            await habitVM.addHabit(title: title, description: description, goal: enableGoal ? Int(goal) : nil)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHabitView()
}
