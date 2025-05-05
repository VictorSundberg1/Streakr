//
//  StreakrApp.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-29.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct StreakrApp: App {
    @StateObject private var authVM = AuthViewModel()
    @StateObject private var habitVM = HabitViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            if authVM.user != nil {
                HomeView()
            } else {
                LoginView()
            }
        }
        .environmentObject(authVM)
        .environmentObject(habitVM)
    }
}
