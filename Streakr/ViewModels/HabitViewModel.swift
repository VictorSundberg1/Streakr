//
//  HabitViewModel.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    
    private var db = Firestore.firestore()
    
    private var userId: String? {
        Auth.auth().currentUser?.uid
    }
    
    init() {
        Task {
            await fetchHabits()
        }
    }
    
    func fetchHabits() async {
        guard let userId else { return }
        
        do {
            let snapshot = try await db.collection("users")
                .document(userId)
                .collection("habits")
                .getDocuments()
            
            self.habits = try snapshot.documents.compactMap {
                try $0.data(as: Habit.self)
            }
            .sorted(by: { $0.streak > $1.streak})
        } catch {
            print("Error fetching habits: \(error.localizedDescription)")
        }
    }
    
    
    func addHabit(title: String, description: String?, goal: Int?) async {
        guard let userId else { return }
        
        let newHabit = Habit(
            id: nil,
            title: title,
            description: description,
            goal: goal,
            createdAt: Date(),
            logs: []
        )
        
        do {
            let ref = try await db.collection("users")
                .document(userId)
                .collection("habits")
                .addDocument(from: newHabit)
            
            var savedHabit = newHabit
            savedHabit.id = ref.documentID
            self.habits.append(savedHabit)
            
        } catch {
            print("Error adding habit: \(error.localizedDescription)")
        }
    }
    
    
    func logToday(for habit: Habit) async {
        guard let userId, let id = habit.id else { return }
        
        var updatedHabit = habit
        let today = Calendar.current.startOfDay(for: Date())
        
        if !updatedHabit.logs.contains(where: { Calendar.current.isDate($0, inSameDayAs: today)}) {
            updatedHabit.logs.append(today)
            
            do {
                try await db.collection("users")
                    .document(userId)
                    .collection("habits")
                    .document(id)
                    .setData(from: updatedHabit)
                
                if let index = self.habits.firstIndex(where: { $0.id == id}) {
                    self.habits[index] = updatedHabit
                }
            } catch {
                print("Failed to log date: \(error.localizedDescription)")
            }
        }
    
    }
    
    func deleteHabit(at offsets: IndexSet) async {
        guard let userId else { return }
        
        for index in offsets {
            let habit = habits[index]
            guard let habitId = habit.id else { continue }
            
            do {
                try await db.collection("users")
                    .document(userId)
                    .collection("habits")
                    .document(habitId)
                    .delete()
            } catch {
                print("Failed to delete \(error.localizedDescription)")
            }
        }
        habits.remove(atOffsets: offsets)
    }
    
    
    private static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
