//
//  Habit.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import Foundation
import FirebaseFirestore

struct Habit: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var createdAt: Date
    var streak: Int
    var logs: [String]
    
    init(title: String) {
        self.title = title
        self.createdAt = Date()
        self.streak = 0
        self.logs = []
    }
}
