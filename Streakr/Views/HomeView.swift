//
//  ContentView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-29.
//

import SwiftUI

struct HomeView: View {
    //check for dark/light mode preferense
    @AppStorage("isDarkMode") private var isDarkMode = false
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
        //updates the light/darkmode depending on value in isDarkMode
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    HomeView()
}
