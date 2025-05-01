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
    
    var userId: String? {
        Auth.auth().currentUser?.uid
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
        } catch {
            print("Error fetching habits: \(error.localizedDescription)")
        }
    }
    
    func addHabit(title: String) async {
        guard let userId else { return }
        
        let newHabit = Habit(title: title)
        do {
            _ = try db.collection("users")
                .document(userId)
                .collection("habits")
                .addDocument(from: newHabit)
            
            await fetchHabits()
        } catch {
            print("Error adding habit: \(error.localizedDescription)")
        }
    }
    
    func logToday(for habit: Habit) async {
        guard let userId, let habitId = habit.id else { return }
        
        let today = Self.formattedDate(Date())
        var updatedHabit = habit
        
        if !updatedHabit.logs.contains(today) {
            updatedHabit.logs.append(today)
            updatedHabit.streak += 1
            
            do {
                try db.collection("users")
                    .document(userId)
                    .collection("habits")
                    .document(habitId)
                    .setData(from: updatedHabit)
                
                await fetchHabits()
            } catch {
                print("Error logging date \(error.localizedDescription)")
            }
        }
    }
    
    private static func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}
