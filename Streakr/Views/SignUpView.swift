//
//  SignUpView.swift
//  Streakr
//
//  Created by Victor Sundberg on 2025-04-30.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignUpButtonDisabled = true
    @State private var showToast = false
    
    @EnvironmentObject var authVM: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            LinearGradient(colors: [Color(.loginRed), Color(.loginGray)],
                           startPoint: .top,
                           endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Create Account")
                    .font(.title)
                    .foregroundStyle(.black)
                
                InputField(text: $email, placeholder: "Email", icon: "envelope.fill", isSecure: false)
                    .onChange(of: email, enableButton)
                
                InputField(text: $password, placeholder: "Password", icon: "lock.fill", isSecure: true)
                    .onChange(of: password, enableButton)
                
                InputField(text: $confirmPassword, placeholder: "Confirm password", icon: "lock.fill", isSecure: true)
                    .onChange(of: confirmPassword, enableButton)
                
                Button("Create Account") {
                    Task {
                        if password == confirmPassword {
                            await authVM.signUp(email: email, password: password)
                            
                            if authVM.errorMessage != nil {
                                showToast = true
                            } else {
                                dismiss()
                            }
                        } else {
                            authVM.errorMessage = "Passwords does not match"
                            showToast = true
                        }
                    }
                }
                .disabled(isSignUpButtonDisabled)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(isSignUpButtonDisabled ? Color(.loginButtonGray) : Color(.loginButtonBlue))
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 12))
                .shadow(radius: 2)
                
                Button("Back to login") {
                    dismiss()
                }
                .font(.footnote.bold())
                .foregroundStyle(.blue)
                .padding(.top, 10)
            }
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 25))
            .shadow(radius: 2)
            .padding(.horizontal)
        }
        .toast(isShowing: $showToast, message: authVM.errorMessage ?? "Something went wrong!")
    }
    
    private func isEmailValid(_ email: String) -> Bool {
        email.contains("@") && email.contains(".")
    }
    
    private func enableButton() {
        isSignUpButtonDisabled = email.isEmpty || password.isEmpty || !isEmailValid(email) || confirmPassword.isEmpty
    }
    
}



#Preview {
    SignUpView()
}
