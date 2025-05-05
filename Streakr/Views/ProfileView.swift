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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button("sign out"){
            authVM.signOut()
        }
    }
}

#Preview {
    ProfileView()
}
