//
//  ProfileView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    //saves darkmode preference in AppStorage / user defaults
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Profile")
                    .font(.largeTitle.bold())
                
                Spacer()
            }
            
            Form {
                Section("Appearance") {
                    Toggle("Dark Mode", isOn: $isDarkMode)
                }
                
                Section {
                    Button("Sign out"){
                        authVM.signOut()
                    }
                    .font(.subheadline)
                    .foregroundStyle(.red)
                }
            }
            
            Text("Work in progress")
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.8))
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
}

#Preview {
    ProfileView()
}
