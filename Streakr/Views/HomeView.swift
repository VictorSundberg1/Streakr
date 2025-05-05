//
//  ContentView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-29.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab("Overview", systemImage: "house.fill") {
                OverviewView()
            }
            
            Tab("Habits", systemImage: "list.bullet.rectangle") {
                HabitListView()
            }
            
            Tab("Profile", systemImage: "person.fill") {
                ProfileView()
            }
        }
    }
}

#Preview {
    HomeView()
}
