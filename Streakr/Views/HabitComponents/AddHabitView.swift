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
    
    var body: some View {
        NavigationView {
            Form {
                Section("Title") {
                    TextField("Enter habit title", text: $title)
                }
                Section("Description") {
                    TextEditor(text: $description)
                        .frame(minHeight: 100)
                }
                Section("Goal (days)") {
                    VStack(alignment: .leading) {
                        Slider(value: $goal, in: 5...100, step: 1)
                        Text("Goal: \(Int(goal)) days")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .navigationTitle("Add new habit tracker!")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        Task {
                            await habitVM.addHabit(title: title, description: description, goal: Int(goal))
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
