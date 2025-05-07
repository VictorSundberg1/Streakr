//
//  ProfileView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-05-01.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var authVM: AuthViewModel
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Profile")
                    .font(.largeTitle.bold())
                
                Spacer()
            }
            
            Spacer()
            
            Button("Sign out"){
                authVM.signOut()
            }
            .font(.headline)
            .foregroundStyle(.red)
            
            Divider()
            
            Text("Work in progress")
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.8))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
